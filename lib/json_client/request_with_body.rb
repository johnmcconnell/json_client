require 'json_client/request'

module JsonClient
  class RequestWithBody < Request
    attr_reader :params

    def md5
      @md5 ||= ::JsonClient.md5_base64_digest(params)
    end

    def execute!(request)
      if methods.include? request.method
        request.body = params
        super(request)
      else
        fail "#{request.method} must be in #{methods}"
      end
    end

    protected

    def methods
     %w[POST PUT]
    end

    def headers
      super.merge({
        'Content-MD5' => md5
      })
    end
  end
end
