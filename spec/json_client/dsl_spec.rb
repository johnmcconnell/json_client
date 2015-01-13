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

      request do |r|
        r.on :index, use: 'abc'
        r.on :delete, use: 'xyz'
      end

      serialize do |s|
        s.on :index, :show, :read, use: 'hello'
        s.on :delete, use: 'world'
      end
    end

    # return the class
    A
  end

  let(:serializers) do
    example_class.new.serializers
  end

  let(:serializers) do
    example_class.new.serializers
  end

  describe '#serializers' do
    it 'adds a way of dynamically adding serializers' do

      expect(serializers.index).to eq 'hello'
      expect(serializers.show).to eq 'hello'
      expect(serializers.read).to eq 'hello'

      expect(serializers.delete).to eq 'world'
    end
  end

  describe '#serializers' do
    it 'adds a way of dynamically adding serializers' do

      expect(serializers.index).to eq 'hello'
      expect(serializers.show).to eq 'hello'
      expect(serializers.read).to eq 'hello'

      expect(serializers.delete).to eq 'world'
    end
  end
end
