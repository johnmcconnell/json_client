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
require 'json_client/base_responses/index'
require 'json_client/base_responses/show'
require 'json_client/base_responses/create'
require 'json_client/base_responses/update'
require 'json_client/base_responses/destroy'

module JsonClient
  class Base
    extend DSL
    attr_reader :api_key, :api_password, :pather

    requests do |r|
      r.on :index, use: BaseRequests::Index.new
      r.on :show, use: BaseRequests::Show.new
      r.on :create, use: BaseRequests::Create.new
      r.on :update, use: BaseRequests::Update.new
      r.on :destroy, use: BaseRequests::Destroy.new
    end

    responses do |r|
      r.on :index, use: BaseResponses::Index
      r.on :show, use: BaseResponses::Show
      r.on :create, use: BaseResponses::Create
      r.on :update, use: BaseResponses::Update
      r.on :destroy, use: BaseResponses::Destroy
    end

    serializers do |s|
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
      result(:index, nil)
    end

    def show(id)
      result(:show, nil, id)
    end

    def create(model)
      result(:create, model)
    end

    def update(id, model)
      result(:update, model, id)
    end

    def destroy(id)
      result(:destroy, nil, id)
    end

    protected

    def result(name, model, id = nil)
      response_class = responses.public_send(name)
      response_class.new(fetch_response(name, model, id))
    end

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
