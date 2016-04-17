require 'slack-notifier'
require 'core_ext/hash'

module Gmail
  module Slack
    class Notifier
      class SlackClient < ::Slack::Notifier

        def initialize(params)
          super params[:webhook_url], channel: params[:channel].nil? ? nil : params[:channel]
        end

        def ping(message, options={})
          message[:text] = message[:text].to_slack_message
          super message, options
        end

      end
    end
  end
end
