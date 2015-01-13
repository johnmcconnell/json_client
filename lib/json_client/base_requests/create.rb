require_relative 'request'

module JsonClient
  module BaseRequests
    class Create < Request
      def fetch(url, auth_params, params)
        client.post(
          url,
          auth_params.merge(params).to_json,
          content_type: :json,
          accept: :json
        )
      end
    end
  end
end
