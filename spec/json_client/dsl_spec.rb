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

      response do |r|
        r.on :index, use: '0'
        r.on :show, use: '1'
      end
    end

    # return the class
    A
  end

  let(:serializers) do
    example_class.new.serializers
  end

  let(:requests) do
    example_class.new.requests
  end

  let(:responses) do
    example_class.new.responses
  end


  describe '#serializers' do
    it 'adds a way of dynamically adding serializers' do

      expect(serializers.index).to eq 'hello'
      expect(serializers.show).to eq 'hello'
      expect(serializers.read).to eq 'hello'

      expect(serializers.delete).to eq 'world'
    end
  end

  describe '#responses' do
    it 'adds a way of dynamically adding responses' do
      expect(responses.index).to eq '0'
      expect(responses.show).to eq '1'
    end
  end

  describe '#requests' do
    it 'adds a way of dynamically adding requests' do
      expect(requests.index).to eq 'abc'
      expect(requests.delete).to eq 'xyz'
    end
  end
end
