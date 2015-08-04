module JsonClient
  module Update
    class Request < ::JsonClient::RequestWithBody
      def fetch
        body = auth_params.merge(params).to_json

        client.put(
          url,
          body,
          'content-md5' => md5(body)
        )
      end
    end
  end
end
