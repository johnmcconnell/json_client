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

```
require 'json_client'
class CrudClient < JsonClient::AbstractClient
end

pather = JsonClient::Pather.new(
  'https://my.host.com',
  'api/v1',
  'object'
)

config = {
  api_key: 'api_key',
  api_password: 'api_password'
}


client = CrudClient.new(pather, config)

# GET https://my.host.com/api/v1/objects?api_key=api_key&api_password=api_password
client.index.json
 => { 'server_json' : 'is_parsed_here' }



# GET https://my.host.com/api/v1/object/2?api_key=api_key&api_password=api_password
client.show(2).json # fetches from
 => { 'object_json' : 'is_parsed_here' }

# and others look at the unit tests for guidance!
```

## Contributing

1. Fork it ( https://github.com/johnmcconnell/json_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
