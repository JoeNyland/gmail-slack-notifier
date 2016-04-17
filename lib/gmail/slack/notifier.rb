require 'gmail/slack/notifier/version'
require 'gmail/slack/notifier/gmail_client'
require 'gmail/slack/notifier/slack_client'
require 'gmail/slack/notifier/exceptions'

module Gmail
  module Slack
    class Notifier

      attr_reader :gmail_client, :slack_client

      def initialize(params = {})
        @gmail_client = GmailClient.new
        @slack_client = SlackClient.new(params[:slack])
      end

      def gmail_client=(client)
        raise Exceptions::GmailClient::Error unless client.is_a? GmailClient
      end

      def slack_client=(client)
        raise Exceptions::SlackClient::Error unless client.is_a? SlackClient
      end

    end
  end
end
