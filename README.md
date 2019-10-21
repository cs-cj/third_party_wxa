# ThirdPartyWxa

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/third_party_wxa`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'third_party_wxa'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install third_party_wxa

## Usage

```ruby
ThirdPartyWxa.configure do |config|
  config.appid = appid
  config.appsecret = appsecret
end
```

when workers of your web server are more than one， configure:

```ruby
redis = Redis.new
ThirdPartyWxa.configure do |config|
  config.appid = appid
  config.appsecret = appsecret
  config.redis = redis
  config.redis_key = redis_key
end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/third_party_wxa.
