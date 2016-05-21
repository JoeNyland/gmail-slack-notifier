# Gmail::Slack::Notifier

[![Build Status](https://travis-ci.org/MasterRoot24/gmail-slack-notifier.svg?branch=master)](https://travis-ci.org/MasterRoot24/gmail-slack-notifier)
[![Gem Version](https://badge.fury.io/rb/gmail-slack-notifier.svg)](https://badge.fury.io/rb/gmail-slack-notifier)
[![Code Climate](https://codeclimate.com/github/MasterRoot24/gmail-slack-notifier/badges/gpa.svg)](https://codeclimate.com/github/MasterRoot24/gmail-slack-notifier)
[![Test Coverage](https://codeclimate.com/github/MasterRoot24/gmail-slack-notifier/badges/coverage.svg)](https://codeclimate.com/github/MasterRoot24/gmail-slack-notifier/coverage)
[![InchCI](https://inch-ci.org/github/MasterRoot24/gmail-slack-notifier.svg?branch=master)](https://inch-ci.org/github/MasterRoot24/gmail-slack-notifier)

Polls your [Gmail][2] mailbox and pings a message in [Slack][3] when you get a new email.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gmail-slack-notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gmail-slack-notifier

## Usage

### Command line options
With the gem installed, you should be able to run `gmail-slack-notifier.rb` with the following options:

```bash
Usage: gmail-slack-notifier.rb [options]
Required:
    -w SLACK_WEBHOOK_URL,            Slack webhook URL
        --slack-webhook-url
    -e, --gmail-email GMAIL_EMAIL    Email address for the Gmail account to login to
    -p GMAIL_PASSWORD,               Gmail password
        --gmail-password
Optional:
    -i GMAIL_POLL_INTERVAL,          Gmail poll interval
        --gmail-poll-interval
```

### Slack Incoming Webhook
In order to push notifications to Slack, you will need to [setup an Incoming Webhook in your Slack team][1]. When
setting up an Incoming Webhook, I suggest you choose the channel to post to as `@slackbot` so that only you are
notified of new emails. When complete, copy the Webhook URL that Slack generates for you and pass it in with the
`--slack-webhook-url` or `-w` option.

### Example
```bash
gmail-slack-notifier.rb -e me@gmail.com -p my_super_secure_password_123@gmail.com -w https://hooks.slack.com/services/qwerty/ytrewq/qwertyqwertyqwerty
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MasterRoot24/gmail-slack-notifier. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[1]: https://my.slack.com/services/new/incoming-webhook/
[2]: https://www.gmail.com
[3]: https://slack.com
