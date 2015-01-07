require 'rest_client'
require 'json_client/responses'
require 'json_client/requests'

module JsonClient
  class Base
    attr_reader :api_key, :api_password, :pather

    def initialize(pather, config)
      @api_key = config[:api_key]
      @api_password = config[:api_password]
      @pather = pather
      validate_variables
    end

    def index
      response = requestors.index.new.fetch(request_path, auth_params)
      responders.index.new(response.body, response.code)
    end

    def show(id)
      response = requestors.show.new.fetch(request_path(id), auth_params)
      responders.show.new(response.body, response.code)
    end

    def create(model)
      response = requestors.create.new.fetch(
        request_path, auth_params, model
      )
      responders.create.new(response.body, response.code)
    end

    def update(id, model)
      response = requestors.update.new.fetch(
        request_path(id), auth_params, model
      )
      responders.update.new(response.body, response.code)
    end

    def destroy(id)
      requestors.destroy.new.fetch(
        request_path(id), auth_params, model
      )
      responders.destroy.new(response.body, response.code)
    end

    protected

    def requestors
      @requestors ||= Requests.new
    end

    def responders
      @responders ||= Responses.new
    end

    def update_params(model)
      model.to_json
    end

    def request_path(id = nil)
      pather.path(id)
    end

    def auth_params
      {
        api_key: api_key,
        api_password: api_password
      }
    end

    private

    def validate_variables
      fail 'api_key must be set' if api_key.nil?
      fail 'api_password must be set' if api_password.nil?
      fail 'pather must be set' if pather.nil?
    end
  end
end
