require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::UriBuilder do
  let(:host) do
    'www.example.com'
  end

  let(:relative_path) do
    'api/v1'
  end

  let(:model_name) do
    'models'
  end

  let(:example_show_path) do
    'www.example.com:80/api/v1/models/1'
  end

  let(:example_index_path) do
    'www.example.com:80/api/v1/models'
  end

  let(:example_show_uri) do
    'http://www.example.com/api/v1/models/1'
  end

  let(:example_index_uri) do
    'http://www.example.com/api/v1/models'
  end

  subject do
    described_class.new(
      host, relative_path, model_name
    )
  end

  describe '#path' do
    context 'with id not given' do
      it 'creates the full path with id at the end' do
        expect(subject.path).to eq example_index_path
      end
    end

    context 'with id given' do
      it 'creates the full path with id at the end' do
        expect(subject.path(1)).to eq example_show_path
      end
    end
  end

  describe '#uri' do
    context 'with id not given' do
      it 'creates the full path with id at the end' do
        expect(subject.uri.to_s).to eq example_index_uri
      end
    end

    context 'with id given' do
      it 'creates the full path with id at the end' do
        expect(subject.uri(1).to_s).to eq example_show_uri
      end
    end
  end
end
