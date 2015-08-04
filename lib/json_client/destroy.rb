module JsonClient
  module Destroy
    class Request < ::JsonClient::Request
      def fetch
        client.delete(
          url, params: auth_params
        )
      end
    end
  end
end
