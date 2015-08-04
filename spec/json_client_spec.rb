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
      client_id: '0',
      secret_key: 'dummy_key',
      host: 'account-authenticator.herokuapp.com'
    }
  end

  let(:uri_builder) do
    JsonClient::UriBuilder.new(
      config[:host],
      'etc',
      'end'
    )
  end

  subject do
    described_class.new(
      uri_builder,
      config
    )
  end

  describe '::new' do
    it 'creates a new base client' do
      expect(subject.client_id).to eq config[:client_id]
      expect(subject.secret_key).to eq config[:secret_key]
    end
  end

  describe '::b64_encode' do
    it 'base64 encodes a string' do
      expect(described_class.b64_encode('0')).to eq('MA==')
    end
  end

  describe '::md5_base64_digest' do
    it 'creates an md5 digest for string' do
      expect(
        described_class.md5_base64_digest('hello world')
      ).to eq('XrY7u+Ae7tCTyyK7j1rNww==')
    end
  end
end
