require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient do
  let(:config) do
    {
      api_key: '124ecd49-07fd-4553-a5cd-0178b7fa8b3f',
      api_password: 'IIoclO7kmQqJ1wixWrAuOA',
      host: 'http://account-authenticator.herokuapp.com'
    }
  end

  describe '::register' do
    it 'registers a configuration to be used when invoked with ::new' do
      client = described_class.new(
        JsonClient::Pather.new(
          config[:host],
          'etc',
          'end'
        ),
        config
      )
      expect(client.pather.host).to eq config[:host]
      expect(client.api_key).to eq config[:api_key]
      expect(client.api_password).to eq config[:api_password]
    end
  end
end
