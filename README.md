# Grape::Msgpack

[![Gem Version](https://badge.fury.io/rb/grape-msgpack.png)](http://badge.fury.io/rb/grape-msgpack) [![Build Status](https://travis-ci.org/rosylilly/grape-msgpack.png?branch=master)](https://travis-ci.org/rosylilly/grape-msgpack) [![Coverage Status](https://coveralls.io/repos/rosylilly/grape-msgpack/badge.png?branch=master)](https://coveralls.io/r/rosylilly/grape-msgpack?branch=master) [![Code Climate](https://codeclimate.com/github/rosylilly/grape-msgpack.png)](https://codeclimate.com/github/rosylilly/grape-msgpack)

Message pack formatter for grape.

## Installation

Add this line to your application's Gemfile:

    gem 'grape-msgpack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape-msgpack

## Usage

set default format msgpack:

```ruby
class TwitterAPI < Grape::API
  default_format :msgpack
end
```

and grape-msgpack supoorts grape-entity:

```ruby
class ModelEntity < Grape::Entity
  expose :id
end

class ModelAPI < Grape::API
  default_format :msgpack

  get ':id' do
    present Model.find(params[:id]), with: ModelEntity
    # => { 'id' => 1 }
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
