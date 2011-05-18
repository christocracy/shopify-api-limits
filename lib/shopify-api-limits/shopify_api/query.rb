module ShopifyAPI
  module Query
    
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end
    
    module ClassMethods
      QUERY_LIMIT = 250
      def all(*config)                   
        model = const_get(config.shift.to_s.classify)
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