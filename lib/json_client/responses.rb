require_relative 'base_responses/index'
require_relative 'base_responses/show'
require_relative 'base_responses/create'
require_relative 'base_responses/update'
require_relative 'base_responses/destroy'

module JsonClient
  class Responses
    def index
      BaseResponses::Index
    end

    def show
      BaseResponses::Show
    end

    def create
      BaseResponses::Create
    end

    def update
      BaseResponses::Update
    end

    def destroy
      BaseResponses::Destroy
    end
  end
end
