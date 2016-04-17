module Gmail
  module Slack
    class Notifier
      class Exceptions
        class ArgumentError < StandardError; end
        class GmailClient
          class Error < StandardError; end
        end
        class SlackClient
          class Error < StandardError; end
        end
      end
    end
  end
end

