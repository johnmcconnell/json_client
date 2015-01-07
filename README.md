# JsonClient
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

I've avoided using a DSL in favor of good engineering principals. I am
hoping the DSL will come after.


```
require 'json_client'

class Client < JsonClient::Base
  def initialize(config)
    super
  end

  def pather
    @pather ||=
      JsonClient::Pather.new(
        'https://example.host.com',
        'api/v1',
        'objects'
      )
  end
end

config = {
  api_key: 'api_key',
  api_password: 'api_password'
}

client = Client.new(config)

# GET https://example.host.com/api/v1/objects?api_key=api_key&api_password=api_password
client.index.json
 => { 'server_json' : 'is_parsed_here' }

# GET https://my.host.com/api/v1/objects/2?api_key=api_key&api_password=api_password
client.show(2).json
 => { 'object_json' : 'is_parsed_here' }
```

## Best Guide

The best guide is [this
test](https://github.com/johnmcconnell/json_client/blob/master/spec/json_client/base_spec.rb).
Sorry non rspec people

## Contributing

1. Fork it ( https://github.com/johnmcconnell/json_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
