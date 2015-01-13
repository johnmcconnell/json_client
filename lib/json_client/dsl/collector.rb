require 'json_client/dsl/collector'

module JsonClient
  module DSL
    class Collector
      def method_missing(method_name, *collection)
        define_singleton_method(method_name) do
          collection.first
        end
      end
    end
  end
end
