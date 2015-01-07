module JsonClient
  module BaseRequests
    class Request
      attr_reader :auth_params

      def initialize(auth_params)
        @auth_params = auth_params
      end

      protected

      def client
        RestClient
      end
    end
  end
end
