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

  let(:pather) do
    JsonClient::Pather.new(
      config[:host],
      'etc',
      'end'
    )
  end

  subject do
    described_class.new(
      pather,
      config
    )
  end

  describe '::new' do
    it 'creates a new base client' do
      expect(subject.api_key).to eq config[:api_key]
      expect(subject.api_password).to eq config[:api_password]
    end
  end
end
