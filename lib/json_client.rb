require "json_client/version"
require "json_client/abstract_client"
require "json_client/pather"

module JsonClient
  def self.new(pather, config)
    AbstractClient.new(pather, config)
  end
end
