require_relative 'response'

module JsonClient
  module AbstractResponses
    class Destroy < Response
      def initialize(body, code)
        super
      end
    end
  end
end
