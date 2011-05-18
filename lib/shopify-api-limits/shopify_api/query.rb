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
        rs = []
        if count > 0          
          1.upto((count.to_f/QUERY_LIMIT).ceil) {|page|                        
            rs.concat model.send(:find, :all, :params => {:page => page}.merge(args[:params]))
          }
        end
        rs
      end
    end
  end
end