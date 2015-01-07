require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::Requests do
  subject { described_class.new }

  describe '#index' do
    it 'returns a index request class' do
      expect(subject.index).to be JsonClient::BaseRequests::Index
    end
  end

  describe '#show' do
    it 'returns a show request class' do
      expect(subject.show).to be JsonClient::BaseRequests::Show
    end
  end

  describe '#create' do
    it 'returns a create request class' do
      expect(subject.create).to be JsonClient::BaseRequests::Create
    end
  end

  describe '#update' do
    it 'returns an update request class' do
      expect(subject.update).to be JsonClient::BaseRequests::Update
    end
  end

  describe '#destroy' do
    it 'returns a destroy request class' do
      expect(subject.destroy).to be JsonClient::BaseRequests::Destroy
    end
  end
end
