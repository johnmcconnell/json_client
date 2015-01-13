require_relative 'request'

module JsonClient
  module BaseRequests
    class Show < Request
      def fetch(url, auth_params, params)
        client.get url, params: auth_params
      end
    end
  end
end
