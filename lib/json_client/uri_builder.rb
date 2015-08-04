module JsonClient
  class UriBuilder
    attr_reader :host, :ext, :name, :port, :ssl

    def initialize(host, ext, name, port = '80', ssl = false)
      @host = host
      @ext = ext
      @name = name
      @port = port
      @ssl = ssl
    end

    def path(id = nil)
      base = "#{host}:#{port}"
      if id.nil?
        base + "/#{ext}/#{name}"
      else
        base + "/#{ext}/#{name}/#{id}"
      end
    end

    def uri(id = nil)
      p = path(id)

      if ssl
        p = "https://#{p}"
      else
        p = "http://#{p}"
      end

      URI(p)
    end
  end
end
