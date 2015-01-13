require 'json_client/dsl/on_use_collector'
require 'json_client/dsl/collector'

module JsonClient
  module DSL
    class SerializersCollector < OnUseCollector

      protected

      def collector_name
        'serializer'
      end
    end
  end
end
