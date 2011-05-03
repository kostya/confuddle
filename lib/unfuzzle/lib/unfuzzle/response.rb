module Unfuzzle
  
  # = Response
  #
  # A simple wrapper around an HTTP response from the Unfuddle API
  #
  class Response
    
    # Create a new response from an HTTP response object
    def initialize(http_response)
      @http_response = http_response
    end
    
    # Was there an error produced as part of the request?
    def error?
      !@http_response.is_a?(Net::HTTPSuccess)
    end
    
    # Raw body of the HTTP response
    def body
      @http_response.body
    end
    
  end
end