module JsonClient
  module Index
    class Request < ::JsonClient::Request
      def fetch
        client.get url, params: auth_params
      end
    end
  end
end
