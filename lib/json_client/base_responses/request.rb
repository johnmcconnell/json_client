require 'http_client'

module JsonClient
  module BaseResponses
    class Request

      protected

      def client
        RestClient
      end
    end
  end
end
