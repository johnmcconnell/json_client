module JsonClient
  module BaseResponses
    class Response
      attr_reader :raw_response

      def initialize(raw_response)
        @raw_response = raw_response
      end

      def method_missing(name, *args)
        raw_response.public_send(name, *args)
      end

      def json
        parse_json
      end

      protected

      def parse_json
        @parse_json ||= JSON.parse(body)
      end
    end
  end
end
