require 'rest_client'

require_relative 'abstract_responses/index'
require_relative 'abstract_responses/show'
require_relative 'abstract_responses/create'
require_relative 'abstract_responses/update'
require_relative 'abstract_responses/destroy'

module JsonClient
  class AbstractClient
    attr_reader :api_key, :api_password, :pather

    def initialize(pather, config)
      @api_key = config[:api_key]
      @api_password = config[:api_password]
      @pather = pather
      validate_variables
    end

    def index
      uri = request_path
      response = RestClient.get uri, params: auth_params
      index_response_factory.new(response.body, response.code)
    end

    def show(id)
      uri = request_path(id)
      response = RestClient.get uri, params: auth_params
      show_response_factory.new(response.body, response.code)
    end

    def create(model)
      uri = request_path
      response = RestClient.post(
        uri,
        auth_params.merge(create_params(model)).to_json,
        content_type: :json,
        accept: :json
      )
      create_response_factory.new(response.body, response.code)
    end

    def update(id, model)
      uri = request_path(id)
      response = RestClient.put(
        uri,
        auth_params.merge(update_params(model)).to_json,
        content_type: :json,
        accept: :json
      )
      update_response_factory.new(response.body, response.code)
    end

    def destroy(id)
      uri = request_path(id)
      response = RestClient.delete(
        uri, params: auth_params
      )
      destroy_response_factory.new(response.body, response.code)
    end

    protected

    def index_response_factory
      AbstractResponses::Index
    end

    def show_response_factory
      AbstractResponses::Show
    end

    def create_response_factory
      AbstractResponses::Create
    end

    def update_response_factory
      AbstractResponses::Update
    end

    def destroy_response_factory
      AbstractResponses::Destroy
    end

    def create_params(model)
      model.to_json
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
      fail 'api_password must be set' if api_key.nil?
      fail 'pather must be set' if api_key.nil?
    end
  end
end
