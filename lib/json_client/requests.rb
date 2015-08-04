require 'json_client/request_with_body'
require 'json_client/request_without_body'

module JsonClient
  module Requests
    class Create < ::JsonClient::RequestWithBody
      def fetch
        execute!(request)
      end

      def request
        client::Post.new(
          uri,
          headers
        )
      end
    end

    class Update < ::JsonClient::RequestWithBody
      def fetch
        execute!(request)
      end

      def request
        client::Put.new(
          uri,
          headers
        )
      end
    end

    class Index < ::JsonClient::RequestWithoutBody
      def fetch
        execute!(request)
      end

      def request
        client::Get.new(
          uri,
          headers
        )
      end
    end

    class Show < ::JsonClient::RequestWithoutBody
      def fetch
        execute!(request)
      end

      def request
        client::Get.new(
          uri,
          headers
        )
      end
    end

    class Destroy < ::JsonClient::RequestWithoutBody
      def fetch
        execute!(request)
      end

      def request
        client::Delete.new(
          uri,
          headers
        )
      end
    end
  end
end
