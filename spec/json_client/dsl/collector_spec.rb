require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::DSL::Collector do
  let(:collected) do
    'hello world'
  end

  subject { described_class.new }

  describe '::method_missing' do
    it 'defines the method and returns the first argument' do
      subject.index collected

      expect(subject.index).to eq 'hello world'
    end
  end
end
