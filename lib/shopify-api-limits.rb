$:.unshift File.dirname(__FILE__)

module ShopifyAPI
  module Limits
    # Connection hack
    require 'shopify-api-limits/active_resource/connection'
    
    require 'shopify-api-limits/shopify_api/shopify_api'
    
    class Error < StandardError
      def self.status_code(code = nil)
        return @code unless code
        @code = code
      end
      
      def status_code
        self.class.status_code
      end
    end

    class GlobalError < Error; status_code(1) ; end
    class ShopError < Error; status_code(2) ; end
  end
end

ShopifyAPI.send(:include, ShopifyAPI::Limits)