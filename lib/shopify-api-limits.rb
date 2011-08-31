$:.unshift File.dirname(__FILE__)

module ShopifyAPI
  module Limits
    # Connection hack
    require 'shopify_api'
    require 'shopify-api-limits/active_resource/connection'
    require 'shopify-api-limits/shopify_api/base'
    
    require 'shopify-api-limits/shopify_api/limits'
    
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end
    
    class Error < StandardError; end
    class GlobalError < Error; end
    class ShopError < Error; end
    
  end
end

ShopifyAPI.send(:include, ShopifyAPI::Limits)
