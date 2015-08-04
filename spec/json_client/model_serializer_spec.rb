require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::ModelSerializer do
  let(:model_name) do
    :account
  end

  let(:model) do
    {a: 0, b: 1}
  end

  let(:hash_model) do
    {account: {a: 0, b: 1}}
  end

  let(:serialized) do
    hash_model.to_json
  end

  subject do
    described_class.new(model_name: model_name)
  end

  describe '#to_h' do
    it 'serializes the model adds the model name as key' do
      expect(subject.to_h(model)).to eq hash_model
    end
  end

  describe '#serialize' do
    it 'serializes the model adds the model name as key' do
      expect(subject.serialize(model)).to eq serialized
    end
  end
end
