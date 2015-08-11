module JsonClient
  module Create
    class Request < ::JsonClient::RequestWithBody
      def fetch
        fetch_method(:post)
      end
    end
  end
end
