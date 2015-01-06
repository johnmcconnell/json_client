require_relative 'response'

module JsonClient
  module AbstractResponses
    class Create < Response
      def initialize(body, code)
        super
      end
    end
  end
end
