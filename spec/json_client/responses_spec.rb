require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::Responses do
  subject { described_class.new }

  describe '#index' do
    it 'returns a index response class' do
      expect(subject.index).to be JsonClient::BaseResponses::Index
    end
  end

  describe '#show' do
    it 'returns a show response class' do
      expect(subject.show).to be JsonClient::BaseResponses::Show
    end
  end

  describe '#create' do
    it 'returns a create response class' do
      expect(subject.create).to be JsonClient::BaseResponses::Create
    end
  end

  describe '#update' do
    it 'returns an update response class' do
      expect(subject.update).to be JsonClient::BaseResponses::Update
    end
  end

  describe '#destroy' do
    it 'returns a destroy response class' do
      expect(subject.destroy).to be JsonClient::BaseResponses::Destroy
    end
  end
end
