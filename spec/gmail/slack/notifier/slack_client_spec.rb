require 'spec_helper'

describe Gmail::Slack::Notifier::SlackClient do

  before do
      expect do
        @client = Gmail::Slack::Notifier::SlackClient.new
      end.not_to raise_exception
  end

  it 'instantiates' do
    expect(@client).to be_a Gmail::Slack::Notifier::SlackClient
  end

end
