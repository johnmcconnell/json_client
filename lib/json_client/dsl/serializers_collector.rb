require 'json_client/dsl/collector'

module JsonClient
  module DSL
    class SerializersCollector
      def on(*names, opts)
        validate_opts!(opts)

        serializer = opts[:with]

        Array(names).each do |name|
          define_singleton_method(name) do
            serializer
          end
        end
      end


      private

      def validate_opts!(opts)
        fail 'with: `serializer` must be defined' if opts[:with].nil?
      end
    end
  end
end
