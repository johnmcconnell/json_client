require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'
require 'json'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::BaseRequests::Request do
  pending '# TODO'
end
