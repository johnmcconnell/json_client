require 'api_auth'

module JsonClient
  class Request
    attr_reader :uri, :auth_params, :params

    def initialize(uri, auth_params, params)
      @uri = uri
      @auth_params = auth_params
      @params = params
    end

    def sign!(request)
      ApiAuth.sign!(
        request,
        auth_params[:client_id],
        auth_params[:secret_key]
      )
    end

    protected

    def execute!(request)
      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(
          sign!(request)
        )
      end
    end

    def client
      Net::HTTP
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    def validate_variables
      %w[url auth_params].each do |name|
        fail "#{name} must be set" if (send name).nil?
      end
    end
  end
end
