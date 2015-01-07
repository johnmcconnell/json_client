require 'rest_client'
require 'json_client/responses'
require 'json_client/requests'

module JsonClient
  class Base
    attr_reader :api_key, :api_password

    def initialize(pather, config)
      @api_key = config[:api_key]
      @api_password = config[:api_password]
      @pather = pather

      validate_variables
    end

    def index
      execute(
        paths.index,
        requests.index,
        responses.index
      )
    end

    def show(id)
      execute(
        paths.show(id),
        requests.show,
        responses.show
      )
    end

    def create(model)
      uri = request_path
      response = RestClient.post(
        uri,
        auth_params.merge(create_params(model)).to_json,
        content_type: :json,
        accept: :json
      )
      responses.create.new(response.body, response.code)
    end

    def update(id, model)
      uri = request_path(id)
      response = RestClient.put(
        uri,
        auth_params.merge(update_params(model)).to_json,
        content_type: :json,
        accept: :json
      )
      responses.update.new(response.body, response.code)
    end

    def destroy(id)
      uri = request_path(id)
      response = RestClient.delete(
        uri, params: auth_params
      )
      responses.destroy.new(response.body, response.code)
    end

    protected

    def exectute(uri, requester, responder, *args)
      response = requester.fetch(uri, auth_params, args)
      responder.new(response.body, response.code)
    end

    def requests
      @requests ||= Requests.new
    end

    def responses
      @responses ||= Responses.new
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
