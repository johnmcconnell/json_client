# JsonClient
[![Gem
Version](https://badge.fury.io/rb/json_client.svg)](http://badge.fury.io/rb/json_client)
[![Build
Status](https://travis-ci.org/johnmcconnell/json_client.svg?branch=master)](https://travis-ci.org/johnmcconnell/json_client)
[![Coverage
Status](https://coveralls.io/repos/johnmcconnell/json_client/badge.png?branch=master)](https://coveralls.io/r/johnmcconnell/json_client?branch=master)

A simple crud json client so that I don't need to do this for
all my web services

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_client

## Usage

```
require 'json_client'

class Client < JsonClient::Base
  def initialize(config)
    super
  end

  def pather
    @pather ||=
      JsonClient::UriBuilder.new(
        'https://example.host.com',
        'api/v1',
        'objects',
        '80'
      )
  end
end

config = {
  client_id: '1',
  secret_key: 'dummmy_key',
  host: '127.0.0.1',
  port: '3000'
}

client = Client.new(config)

# GET http://example.host.com:80/api/v2/objects/2
# Headers:
# Content-Type: application/json
# Accept: application/json
# Authorization: APIAuth 1:oh3o3h00312h320u530s=
client.index.json
 => { 'server_json' : 'is_parsed_here' }

# GET http://example.host.com:80/api/v2/objects
# Headers:
# Content-Type: application/json
# Accept: application/json
# Authorization: APIAuth 1:oh3o3h00312h320u530s=
client.show(2).json
 => { 'object_json' : 'is_parsed_here' }
```

## Best Guide

Use [this test](https://github.com/johnmcconnell/json_client/blob/master/spec/json_client/base_spec.rb)
as a guide.

## Contributing
Contributions Welcome
