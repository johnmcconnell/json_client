require_relative 'request'

module JsonClient
  module BaseRequests
    class Show < Request
      def initialize(auth_params)
        super
      end

      def fetch(url, id)
        client.get url
      end
    end
  end
end
