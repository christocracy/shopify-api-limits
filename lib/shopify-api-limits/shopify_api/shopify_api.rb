module ShopifyAPI
  # Takes form num_requests_executed/max_requests
  # Eg: 101/3000
  CALL_LIMIT_HEADER_PARAM = {
    :global => 'http_x_shopify_api_call_limit',
    :shop => 'http_x_shopify_shop_api_call_limit'
  }
  
  class << self
    ##
    # How many more API calls can I make?
    # @return {Integer}
    #
    def available_calls
      shop = call_limit(:shop) - call_count(:shop)
      global = call_limit(:global) - call_count(:global)      
      shop < global ? shop : global
    end

    ##
    # Have I reached my API call limit?
    # @return {Boolean}
    #
    def maxed?
      available_calls == 0
    end

    ##
    # How many total API calls can I make?
    # NOTE: subtracting 1 from call_limit because I think ShopifyAPI cuts off at 299/2999 or shop/global limits.
    # @param {Symbol} scope [:shop|:global]
    # @return {Integer}
    #
    def call_limit(scope=:shop)
      @api_call_limit ||= {}
      @api_call_limit[scope] ||= api_call_limit_param(scope).pop.to_i - 1     
    end

    ##
    # How many API calls have I made?
    # @param {Symbol} scope [:shop|:global]
    # @return {Integer}
    #
    def call_count(scope=:shop)
      api_call_limit_param(scope).shift.to_i
    end
    
    ##
    # @return {HTTPResonse}
    #
    def response
      Shop.current unless ActiveResource::Base.connection.response
      ActiveResource::Base.connection.response
    end
    
    private
    
    ##
    # @return {Array}
    #
    def api_call_limit_param(scope)    
      response[CALL_LIMIT_HEADER_PARAM[scope]].split('/')      
    end    
  end  
end
