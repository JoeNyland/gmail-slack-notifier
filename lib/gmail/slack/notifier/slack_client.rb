require 'slack-notifier'

# Takes a hash of data and formats it as a string, ready for sending to Slack
#
# Example input hash:
# {
#   date:    Time.now,
#   from:    'foo.bar@example.com',
#   subject: 'This is a test email from Foo Bar',
#   excerpt: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
# }
#
# Would result in:
#   Date: 2016-04-12 10:36:30 +0100
#   From: foo.bar@example.com
#   Subject: This is a test email from Foo Bar
#   Excerpt: Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#
class Hash
  def format_as_slack_message
    # ToDo: Refactor me!
    a = []
    self.each do |k,v|
      a << "#{k.capitalize}: #{v}"
    end
    a.join "\n"
  end
end

module Gmail
  module Slack
    class Notifier
      class SlackClient < ::Slack::Notifier

        def initialize(params)
          # ToDo: Refactor to throw a suitable exception
          fail 'A Slack webhook URL is required' if params[:webhook_url].nil?
          super params[:webhook_url], channel: params[:channel].nil? ? nil : params[:channel]
        end

        def ping(message, options={})
          message[:text] = message[:text].format_as_slack_message # ToDo: Refactor to be a bang method
          super message, options
        end

      end
    end
  end
end
