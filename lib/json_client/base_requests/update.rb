require_relative 'request'

module JsonClient
  module BaseRequests
    class Update < Request
      def fetch(url, auth_params, model)
        client.put(
          url,
          auth_params.merge(update_params(model)).to_json,
          content_type: :json,
          accept: :json
        )
      end

      protected

      def update_params(model)
        model.to_h
      end
    end
  end
end
