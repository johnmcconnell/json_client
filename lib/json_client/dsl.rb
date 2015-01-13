require 'json_client/dsl/serializers_collector'

module JsonClient
  module DSL
    def serializers_collector
      @collector ||= SerializersCollector.new
    end

    def serializers
      collector = serializers_collector

      yield collector

      define_method :serializers do
        collector
      end
    end
  end
end
