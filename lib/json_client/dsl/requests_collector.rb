require 'json_client/dsl/on_use_collector'
require 'json_client/dsl/collector'

module JsonClient
  module DSL
    class RequestsCollector < OnUseCollector

      protected

      def collector_name
        'request'
      end
    end
  end
end
