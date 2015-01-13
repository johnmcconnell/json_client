require 'json_client/dsl/serializers_collector'
require 'json_client/dsl/requests_collector'

module JsonClient
  module DSL
    def serializers_collector
      @serializers_collector ||= SerializersCollector.new
    end

    def serialize
      collector = serializers_collector

      yield collector

      define_method :serializers do
        collector
      end
    end

    def requests_collector
      @requests_collector ||= RequestsCollector.new
    end

    def request
      collector = requests_collector

      yield collector

      define_method :requests do
        collector
      end
    end
  end
end
