module ShopifyAPI
  # Takes form num_requests_executed/max_requests
  # Eg: 101/3000
  CALL_LIMIT_HEADER_GLOBAL  = 'http_x_shopify_api_call_limit'
  CALL_LIMIT_HEADER_LOCAL   = 'http_x_shopify_shop_api_call_limit'
  
  class << self
    ##
    # How many more API calls can I make?
    #
    def available_calls    
      call_limit - call_count
    end

    ##
    # Have I reached my API call limit?
    #
    def maxed_out?
      call_limit == call_count
    end

    ##
    # How many total API calls can I make?
    # @return Integer
    #
    def call_limit
      @api_call_limit ||= api_call_limit_param.pop.to_i
    end

    ##
    # How many API calls have I made?
    # @return Integer
    def call_count
      api_call_limit_param.shift.to_i
    end

    def api_call_limit_param
      response[CALL_LIMIT_HEADER_GLOBAL].split('/')
    end

    def response
      Shop.current unless ActiveResource::Base.connection.response
      ActiveResource::Base.connection.response
    end
  end  
end
