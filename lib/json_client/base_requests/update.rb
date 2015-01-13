require_relative 'request'

module JsonClient
  module BaseRequests
    class Update < Request
      def fetch(url, auth_params, params)
        client.put(
          url,
          auth_params.merge(params).to_json,
          content_type: :json,
          accept: :json
        )
      end
    end
  end
end
