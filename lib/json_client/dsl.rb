require 'json_client/dsl/serializers_collector'
require 'json_client/dsl/requests_collector'

module JsonClient
  module DSL
    def serializers_collector
      @collector ||= SerializersCollector.new
    end

    def serialize
      collector = serializers_collector

      yield collector

      define_method :serializers do
        collector
      end
    end

    def requests_collector
      @collector ||= RequestsCollector.new
    end

    def request
      collector = requests_collector

      yield collector

      define_method :requestors do
        collector
      end
    end
  end
end
