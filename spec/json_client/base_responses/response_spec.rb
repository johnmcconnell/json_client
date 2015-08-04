require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'
require 'json'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::Response do
  let(:code) do
    200
  end

  let(:body) do
    %q<{ "hello" : "world" }>
  end

  let(:response) do
    Object.new.tap do |r|
      def r.code; 200; end
      def r.body; %q<{ "hello" : "world" }>; end
    end
  end

  let(:json) do
    JSON.parse(body)
  end

  subject do
    described_class.new(
      response
    )
  end

  describe '#json' do
    it 'returns the parsed json from the body' do
      expect(subject.json).to eq json
    end
  end

  describe '#body' do
    it 'returns the body' do
      expect(subject.body).to eq body
    end
  end

  describe '#code' do
    it 'returns the response code' do
      expect(subject.code).to eq code
    end
  end
end
