$:.unshift File.dirname(__FILE__)

module ShopifyAPI
  module Limits
    # Connection hack
    require 'shopify-api-limits/active_resource/connection'
    require 'shopify-api-limits/shopify_api/limits'
    require 'shopify-api-limits/shopify_api/query'
    
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end
    
    class Error < StandardError; end
    class GlobalError < Error; end
    class ShopError < Error; end
    
  end
end

ShopifyAPI.send(:include, ShopifyAPI::Limits)
ShopifyAPI.send(:include, ShopifyAPI::Query)