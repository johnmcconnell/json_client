module JsonClient
  module Show
    class Request < ::JsonClient::Request
      def fetch
        client.get url, params: auth_params
      end
    end
  end
end
