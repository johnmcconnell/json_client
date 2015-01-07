require "json_client/version"
require "json_client/base"
require "json_client/pather"

module JsonClient
  def self.new(pather, config)
    Base.new(pather, config)
  end
end
