module Unfuzzle
  
  # = Request
  #
  # A basic wrapper for GET requests to the Unfuddle API
  #
  class Request 

    # Retrieve a response from the given resource path
    def self.get(resource_path, query = nil)
      request = new(resource_path, nil, query)
      request.get
    end

    # Send a POST request with data and retrieve a Response
    def self.post(resource_path, payload)
      request = new(resource_path, payload)
      request.post
    end
    
    # Send a PUT request with data and retrieve a Response
    def self.put(resource_path, payload)
      request = new(resource_path, payload)
      request.put
    end
    
    # Create a new request for the given resource path
    def initialize(resource_path, payload = nil, query = nil)
      @resource_path = resource_path
      @payload       = payload
      @query = query
    end
    
    def endpoint_uri  # :nodoc:
      url = "https://#{Unfuzzle.subdomain}.unfuddle.com/api/v1#{@resource_path}.xml"
      url += @query if @query
      URI.parse(url)
    end

    def client # :nodoc:
      http = Net::HTTP.new(endpoint_uri.host, endpoint_uri.port)
      if Unfuzzle.use_ssl
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      http
    end

    # Retrieve a response from the current resource path    
    def get
      request = Net::HTTP::Get.new(endpoint_uri.request_uri)
      request.basic_auth Unfuzzle.username, Unfuzzle.password
      Response.new(client.request(request))
    end

    # Send a POST request to the configured endpoint
    def post
      request = Net::HTTP::Post.new(endpoint_uri.request_uri)
      request.basic_auth Unfuzzle.username, Unfuzzle.password
      request.content_type = 'application/xml'

      Response.new(client.request(request, @payload))
    end

    # Send a PUT request to the configured endpoint
    def put
      request = Net::HTTP::Put.new(endpoint_uri.request_uri)
      request.basic_auth Unfuzzle.username, Unfuzzle.password
      request.content_type = 'application/xml'
      
      Response.new(client.request(request, @payload))
    end
    
  end
end
