require_relative 'base_requests/index'
require_relative 'base_requests/show'
require_relative 'base_requests/create'
require_relative 'base_requests/update'
require_relative 'base_requests/destroy'

module JsonClient
  class Requests
    def index
      BaseRequests::Index
    end

    def show
      BaseRequests::Show
    end

    def create
      BaseRequests::Create
    end

    def update
      BaseRequests::Update
    end

    def destroy
      BaseRequests::Destroy
    end
  end
end
