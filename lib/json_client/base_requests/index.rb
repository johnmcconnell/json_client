require_relative 'request'

module JsonClient
  module BaseRequests
    class Index < Request
      def fetch(url, auth_params)
        client.get url, params: auth_params
      end
    end
  end
end
