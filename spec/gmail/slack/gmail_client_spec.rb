require 'spec_helper'

describe Gmail::Slack::Notifier::GmailClient do

  before do
      expect do
        @client = Gmail::Slack::Notifier::GmailClient.new
      end.not_to raise_exception
  end

  it 'instantiates' do
    expect(@client).to be_a Gmail::Slack::Notifier::GmailClient
  end

end
