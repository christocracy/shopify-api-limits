require 'active_resource'

module ActiveResource
  class Connection
    # HACK:  Add an attr_reader for response
    attr_reader :response
    
    # capture the original #handle_response as unbound method instead of using alias 
    handle_response = self.instance_method(:handle_response)
        
    define_method(:handle_response) do |response|
      @response = handle_response.bind(self).call(response)
    end        
  end
end
