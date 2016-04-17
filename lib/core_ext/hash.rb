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
  def to_slack_message
    self.map {|k,v| "#{k.capitalize}: #{v}" }.join "\n"
  end
end
