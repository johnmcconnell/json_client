require 'spec_helper'
require 'rspec/collection_matchers'
require 'json_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe JsonClient::Base do
  let(:config) do
    {
      client_id: '1',
      secret_key: 'dummmy_key',
      host: '127.0.0.1',
      port: '3000'
    }
  end

  let(:uri_builder) do
    JsonClient::UriBuilder.new(
      config[:host],
      'api/v2',
      'accounts',
      config[:port]
    )
  end

  let(:account) do
    {
      account: { username: 'new_username', password: 'new_password' }
    }
  end

  let(:new_account) do
    {
      account: { username: 'new_username_1', password: 'new_password_1' }
    }
  end

  let(:destroy_account) do
    {
      account: { username: 'new_username_2', password: 'new_password_2' }
    }
  end

  let(:updated_account) do
    {
      account: { username: 'updated_username', password: 'updated_password' }
    }
  end

  subject do
    described_class.new(
      uri_builder,
      config
    )
  end

  describe '#all' do
    it 'fetches all the accounts' do
      VCR.use_cassette('all_success') do
        response = subject.index.json

        expect(response['accounts']).not_to be nil
      end
    end
  end

  describe '#create' do
    it 'creates an account' do
      VCR.use_cassette('create_success') do
        response = subject.create(account).json

        expect(response['username']).to eq 'new_username'
        expect(response['id']).not_to be nil
        expect(response['created_at']).not_to be nil
        expect(response['updated_at']).not_to be nil
      end
    end
  end

  describe '#show' do
    it 'fetches the account' do
      VCR.use_cassette('show_success') do
        response = subject.show(2).json

        expect(response['id']).to be 2
        expect(response['created_at']).to eq '2015-08-11 05:46:28 +0000'
        expect(response['updated_at']).to eq '2015-08-11 05:46:28 +0000'
      end
    end
  end

  describe '#update' do
    it 'updates the account' do
      VCR.use_cassette('update_success') do
        r = subject.create(new_account)
        id = r.json['id']

        response = subject.update(id, updated_account).json

        expect(response['username']).to eq updated_account[:username]
        expect(response['id']).to eq id
      end
    end
  end

  describe '#destroy' do
    it 'destroys the account' do
      VCR.use_cassette('destroy_success') do
        r = subject.create(destroy_account)
        id = r.json['id']

        response = subject.destroy(id).json

        expect(response['id']).to eq id
      end
    end
  end
end
