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
          message[:text] = message[:text].format_as_slack_message # ToDo: Refactor to be a bang method
          super message, options
        end

      end
    end
  end
end
