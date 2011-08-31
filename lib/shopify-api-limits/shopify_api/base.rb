require 'active_resource'
##
# Redefines #find_every to automatically compose resultsets from multiple ShopifyAPI queries due to API limit of 250 records / request.
# Seemlessly stitches all requests to #all, #find(:all), etc, as if there were no LIMIT.
# @see http://wiki.shopify.com/Retrieving_more_than_250_Products%2C_Orders_etc.
#
module ShopifyAPI
  class Base < ActiveResource::Base
    SHOPIFY_API_MAX_LIMIT = 250
    
    class << self
      # get reference to unbound class-method #find_every
      find_every = self.instance_method(:find_every)
      
      define_method(:find_every) do |options|
        options[:params] ||= {}
        
        # Determine number of ShopifyAPI requests to stitch together all records of this query.
        limit = options[:params][:limit]
        
        # Bail out to default functionality unless limit == false
        return find_every.bind(self).call(options) unless limit == false
        
        total = count(options).to_f
        options[:params].update(:limit => SHOPIFY_API_MAX_LIMIT)
        pages = (total/SHOPIFY_API_MAX_LIMIT).ceil
          
        # raise Limits::Error if not enough credits to retrieve entire recordset
        raise ShopifyAPI::Limits::Error.new if ShopifyAPI.credit_maxed?

        # Iterate from 1 -> max-pages and call the original #find_every, capturing the responses into one list
        
        rs = []        
        1.upto(pages) {|page| 
          options[:params].update(page: page)
          rs.concat find_every.bind(self).call(options)
        }
        rs                  
      end
    end      
  end
end
