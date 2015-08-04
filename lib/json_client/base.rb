require 'json_client/requests'
require 'json_client/response'
require 'json_client/base_serializer'
require 'json_client/empty_serializer'
require 'json_client/dsl'
require 'pry'

module JsonClient
  class Base
    extend DSL
    attr_reader :secret_key, :client_id, :uri_builder

    J = ::JsonClient
    RS = J::Requests

    requests do |r|
      r.on :index, use: RS::Index
      r.on :show, use: RS::Show
      r.on :create, use: RS::Create
      r.on :update, use: RS::Update
      r.on :destroy, use: RS::Destroy
    end

    responses do |r|
      r.on :index, use: J::Response
      r.on :show, use: J::Response
      r.on :create, use: J::Response
      r.on :update, use: J::Response
      r.on :destroy, use: J::Response
    end

    serializers do |s|
      s.on :create, :update, :destroy, use: J::BaseSerializer.new
      s.on :index, :show, use: J::EmptySerializer.new
    end

    def initialize(uri_builder, config)
      @client_id = config[:client_id]
      @secret_key = config[:secret_key]
      @uri_builder = uri_builder
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

    def result(protocol, model, id = nil)
      responder = responders.for(protocol)

      ## Fetch the response for protocol
      response = fetch_response(protocol, model, id)

      ## Create new response
      responder.new(response)
    end

    def build_request(protocol, model, id = nil)
      ## Get URL path
      uri = uri_builder.uri(id)
      requester = requestors.for(protocol)

      ## Find serializer for model
      serializer = serializers.for(protocol)
      params = serializer.serialize(model)

      ## Build the request object
      requester.new(uri, auth_params, params)
    end

    def fetch_response(protocol, model, id = nil)
      build_request(protocol, model, id).fetch
    end

    def auth_params
      {
        client_id: client_id,
        secret_key: secret_key
      }
    end

    private

    def validate_variables
      %w[uri_builder client_id secret_key].each do |name|
        fail "#{name} must be set" if (send name).nil?
      end
    end
  end
end
