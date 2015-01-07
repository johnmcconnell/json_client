require_relative 'request'

module JsonClient
  module BaseRequests
    class Destroy < Request
      def fetch(url, auth_params)
        client.delete(
          uri, params: auth_params
        )
      end
    end
  end
end
