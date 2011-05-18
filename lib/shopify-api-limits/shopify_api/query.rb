module ShopifyAPI
  module Query
    
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end
    
    module ClassMethods
      QUERY_LIMIT = 250
      
      ##
      # Stitches resultsets where count is greater than Shopify's single query limit of 250, as if there were no limit.
      # Will determine the number of pages of 250 in order to return a single resultset.
      # raises ShopifyAPI::Limits::Error if you haven't enough credits to fetch all your records.
      # 
      def all(model_symbol, *config)                   
        model = const_get(model_symbol.to_s.classify)
        args = config.shift || {}
        args[:params] ||= {}                                   
        count = model.send(:count, :params => args[:params])
        pages = (count.to_f/QUERY_LIMIT).ceil
        raise Limits::Error.new unless credit_left >= pages
        rs = []
        1.upto(pages) {|page| rs.concat model.send(:find, :all, :params => {:page => page}.merge(args[:params])) } if count > 0
        rs
      end
    end
  end
end