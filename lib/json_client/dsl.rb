require 'json_client/dsl/serializers_collector'
require 'json_client/dsl/requests_collector'
require 'json_client/dsl/on_use_collector'

module JsonClient
  module DSL
    def serializers_collector
      @serializers_collector ||= SerializersCollector.new
    end

    def serializers
      collector = serializers_collector

      yield collector

      define_method :serializers do
        collector
      end
    end

    def requests_collector
      @requests_collector ||= RequestsCollector.new
    end

    def requests
      collector = requests_collector

      yield collector

      define_method :requestors do
        collector
      end
    end

    def responses_collector
      @responses_collector ||= OnUseCollector.new
    end

    def responses
      collector = responses_collector

      yield collector

      define_method :responders do
        collector
      end
    end
  end
end
