#!/bin/env ruby

# Workaround for OpenSSL issue with untrusted cert on Mac OS X
ENV['SSL_CERT_FILE'] = Gem.loaded_specs['google-api-client'].full_gem_path+'/lib/cacerts.pem'

require 'google/apis/gmail_v1'
require 'google/apis/pubsub_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Gmail API Ruby Quickstart'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                             "gmail-ruby-quickstart.yaml")
SCOPE = [Google::Apis::GmailV1::AUTH_GMAIL_MODIFY,Google::Apis::PubsubV1::AUTH_PUBSUB]
TOPIC = 'projects/gmail-slack-notifier-1257/topics/push'
SUBSCRIPTION = 'projects/gmail-slack-notifier-1257/subscriptions/push'

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or initialing an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(
      client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(
        base_url: OOB_URI)
    puts "Open the following URL in the browser and enter the " +
             "resulting code after authorization"
    puts url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
  end
  credentials
end

service = Google::Apis::GmailV1::GmailService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

pubsub = Google::Apis::PubsubV1::PubsubService.new
pubsub.authorization = authorize

watch_request = Google::Apis::GmailV1::WatchRequest.new
watch_request.topic_name = TOPIC

service.watch_user('me', watch_request) do |request|
  while true
    # request.update! unless Time.at(request.expiration.to_i / 1000) > Time.now

    # Pull messages
    response = pubsub.pull_subscription(SUBSCRIPTION, Google::Apis::PubsubV1::PullRequest.new)
    response.received_messages.each do |received_message|
      data = received_message.message.data
      puts "Received: #{data}"
    end

    # Acknowledge receipt
    ack_ids = response.received_messages.map{ |msg| msg.ack_id }
    pubsub.acknowledge_subscription(SUBSCRIPTION, Google::Apis::PubsubV1::AcknowledgeRequest.new(ack_ids: ack_ids))

    puts 'Loop complete'

    # Wait
    sleep 3
  end
end
