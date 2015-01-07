require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::Pather do
  let(:host) do
    'https://www.example.com'
  end

  let(:relative_path) do
    'api/v1'
  end

  let(:model_name) do
    'models'
  end

  let(:example_show_path) do
    'https://www.example.com/api/v1/models/1'
  end

  let(:example_index_path) do
    'https://www.example.com/api/v1/models'
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
end
