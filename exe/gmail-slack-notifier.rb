#!/usr/bin/env ruby

require 'gmail/slack/notifier'

# Gmail::Slack::Notifier.new.run

# Gmail.connect!('email','password') do |client|
#
#   # We start monitoring for emails from now onwards
#   last_email_time = Time.now
#
#   # Loop indefinitely, checking for mail every X seconds
#   while true
#
#     # Get all the email in the inbox
#     mail = client.inbox.find
#
#     # Only continue if there's at least one message in the inbox
#     unless mail.empty?
#
#       # Select the messages in the inbox that have been received after the last message that we alerted for
#       mail.select! {|m| Time.parse(m.date).utc > last_email_time.utc }
#
#       # mail now contains new message(s) (if any) that we should alert for
#       unless mail.empty?
#
#         # mail now contains new mail after the last email that we alerted for and there's at least one
#         mail.each do |message|
#           # For now, just puts some basic info about each message
#           puts "New message: #{message.date} -- #{message.subject}"
#         end
#
#         # We want to use the time of the last message on the next iteration of the loop to search for messages after it
#         last_email_time = Time.parse(mail.last.date)
#
#       end
#
#     end
#
#     sleep 10
#
#   end
#
# end

test_email = {
  date:    Time.now,
  from:    'foo.bar@example.com',
  subject: 'This is a test email from Foo Bar',
  excerpt: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
}

notifier = Gmail::Slack::Notifier::SlackClient.new WEBHOOK_URL
notifier.ping(username: TARGET_SLACK_USER,text: to_slack_message(test_email))
