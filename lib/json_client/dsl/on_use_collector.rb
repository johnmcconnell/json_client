module JsonClient
  module DSL
    class OnUseCollector
      def on(*names, opts)
        validate_opts!(opts)

        thing = opts[:use]

        Array(names).each do |name|
          define_singleton_method(name) do
            thing
          end
        end
      end


      protected

      def collector_name
        'thing'
      end

      def use_not_defined_message
        "use: `#{collector_name}` must be defined"
      end

      def validate_opts!(opts)
        fail use_not_defined_message if opts[:use].nil?
      end
    end
  end
end
