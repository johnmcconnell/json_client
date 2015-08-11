require 'json_client/version'
require 'json_client/base'
require 'json_client/model_serializer'
require 'json_client/uri_builder'

require 'digest'

module JsonClient
  class << self
    def new(uri_builder, config)
      Base.new(uri_builder, config)
    end

    def md5_base64_digest(string)
      Digest::MD5.base64digest(string)
    end

    def b64_encode(string)
      Base64.strict_encode64(string)
    end
  end
end
