require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::DSL do
  let(:example_class) do
    class A
      extend JsonClient::DSL

      serializers do |s|
        s.on :index, :show, :read, with: 'hello'
      end
    end

    # return the class
    A
  end

  describe '::serializer' do
    it 'an way of dynamically adding serializers' do
      serializers = example_class.new.serializers

      expect{ serializers.index }.not_to raise_error
      expect(serializers.index.to_s).to eq 'hello'
    end
  end
end
