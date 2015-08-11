module JsonClient
  class RequestWithoutBody < Request
    def fetch(request)
      if methods.include? request.method
        execute!(request)
      else
        fail "#{request.method} must be in #{methods}"
      end
    end

    protected

    def methods
      %w(GET DELETE POST PUT)
    end
  end
end
