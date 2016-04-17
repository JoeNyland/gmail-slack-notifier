#!/usr/bin/env ruby
# ToDo: Check for mandatory options

require 'optparse'
require 'gmail/slack/notifier'

# Parse arguments
options = {}
ARGV << '-h' if ARGV.empty? # Show the help message if no command line arguments are provided
OptionParser.new do |opts|
  opts.on('-w', '--slack-webhook-url SLACK_WEBHOOK_URL', 'Slack webhook URL') do |v|
    options[:slack_webhook_url] = v
  end
  opts.on('-e', '--gmail-email GMAIL_EMAIL', 'Email address for the Gmail account to login to') do |v|
    options[:gmail_email] = v
  end
  opts.on('-p', '--gmail-password GMAIL_PASSWORD', 'Gmail password') do |v|
    options[:gmail_password] = v
  end
  opts.on('-i', '--gmail-poll-interval GMAIL_POLL_INTERVAL', Integer, 'Gmail poll interval') do |v|
    options[:gmail_poll_interval] = v
  end
end.parse!

# Build a notifier object
notifier = Gmail::Slack::Notifier.new(
  gmail: {
      email: options[:gmail_email],
      password: options[:gmail_password]
  },
  slack: {
      webhook_url: options[:slack_webhook_url]
  }
)

# The main mail detection and notification loop
Gmail.connect!(options[:gmail_email],options[:gmail_password]) do |client|

  # We start monitoring for emails from now onwards
  last_email_time = Time.now

  # Loop indefinitely, checking for mail every X seconds
  while true

    # Get all the email in the inbox
    mail = client.inbox.find

    # Only continue if there's at least one message in the inbox
    unless mail.empty?

      # Select the messages in the inbox that have been received after the last message that we alerted for
      mail.select! {|m| Time.parse(m.date).utc > last_email_time.utc }

      # mail now contains new message(s) (if any) that we should alert for
      unless mail.empty?

        # mail now contains new mail after the last email that we alerted for and there's at least one
        mail.each do |message|
          # Send a message to Slack!
          notifier.slack_client.ping(text: {
              date: message.date,
              from: "#{message.from.first.name} #{message.from.first.mailbox}@#{message.from.first.host}",
              subject: message.subject
            })
        end

        # We want to use the time of the last message on the next iteration of the loop to search for messages after it
        last_email_time = Time.parse(mail.last.date)

      end

    end

    # Wait for the poll interval before checking for more email, default to 30 seconds
    sleep options[:gmail_poll_interval] || 30

  end

end
