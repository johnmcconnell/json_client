require 'attr_init'

module JsonClient
  class ModelSerializer
    reader_struct :model_name

    def serialize(model)
      to_h(model).to_json
    end

    def to_h(model)
      { model_name => model.to_h }
    end
  end
end
