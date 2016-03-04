# B2

Ruby Wrapper for Backblaze B2 Api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'b2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install b2

## Usage

Write your api key in config/initializers/b2.rb
```ruby
B2.configuration do |config|
  config.application_key = YOUR-APPLICATION-KEY
  config.account_id = YOUR-ACCOUNT-ID
end
```

## To-Do
* More doc for api call
* integrate with carrierwave
* Test Unit

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/metalkoholic/b2.

1. Fork it ( https://github.com/metalkoholic/b2/fork )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

