module JsonClient
  class BaseSerializer
    def serialize(model)
      if model.nil?
        ''
      else
        model.to_h.to_json
      end
    end

    def to_h(model)
      model.to_h
    end
  end
end
