require 'attr_init'

module JsonClient
  class ModelSerializer
    reader_struct :model_name

    def serialize(model)
      { model_name => model.to_h }
    end
  end
end
