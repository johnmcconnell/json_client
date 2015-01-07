require_relative 'request'

module JsonClient
  module BaseRequests
    class Create < Request
      def fetch(url, auth_params, model)
        client.post(
          url,
          auth_params.merge(create_params(model)).to_json,
          content_type: :json,
          accept: :json
        )
      end

      private

      def create_params(model)
        model.to_h
      end
    end
  end
end
