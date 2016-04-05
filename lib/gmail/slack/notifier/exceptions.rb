module Gmail
  module Slack
    class Notifier
      class Exceptions
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

