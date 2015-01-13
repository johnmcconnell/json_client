
module JsonClient
  class BaseSerializer
    def serialize(model)
      if model.nil?
        {}
      else
        model.to_h
      end
    end
  end
end
