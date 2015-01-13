require 'rest_client'

require 'json_client/dsl'
require 'json_client/responses'
require 'json_client/requests'
require 'json_client/base_serializer'
require 'json_client/empty_serializer'
require 'json_client/base_requests/index'
require 'json_client/base_requests/show'
require 'json_client/base_requests/create'
require 'json_client/base_requests/update'
require 'json_client/base_requests/destroy'

module JsonClient
  class Base
    attr_reader :api_key, :api_password, :pather
    extend DSL

    request do |r|
      r.on :index, use: BaseRequests::Index.new
      r.on :show, use: BaseRequests::Show.new
      r.on :create, use: BaseRequests::Create.new
      r.on :update, use: BaseRequests::Update.new
      r.on :destroy, use: BaseRequests::Destroy.new
    end

    serialize do |s|
      s.on :create, :update, :destroy, use: BaseSerializer.new
      s.on :index, :show, use: EmptySerializer.new
    end

    def initialize(pather, config)
      @api_key = config[:api_key]
      @api_password = config[:api_password]
      @pather = pather
      validate_variables
    end

    def index
      response = fetch_response(:index, nil)
      responders.index.new(response.body, response.code)
    end

    def show(id)
      response = fetch_response(:show, nil, id)
      responders.show.new(response.body, response.code)
    end

    def create(model)
      response = fetch_response(:create, model)
      responders.create.new(response.body, response.code)
    end

    def update(id, model)
      response = fetch_response(:update, model, id)
      responders.update.new(response.body, response.code)
    end

    def destroy(id)
      response = fetch_response(:destroy, nil, id)
      responders.destroy.new(response.body, response.code)
    end

    protected

    def fetch_response(name, model, id = nil)
      path = pather.path(id)
      request = requests.public_send(name)
      serializer = serializers.public_send(name)
      params = serializer.serialize(model)
      fetch(path, request, params)
    end

    def fetch(path, request, params)
      request.fetch(path, auth_params, params)
    end

    def responders
      @responders ||= Responses.new
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
