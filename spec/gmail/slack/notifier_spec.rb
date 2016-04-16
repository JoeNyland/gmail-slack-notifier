require 'spec_helper'

describe Gmail::Slack::Notifier do

  before do
    @notifier = Gmail::Slack::Notifier.new({slack:{webhook_url:''}})
  end

  context 'class variables' do

    it 'has a version number' do
      expect(Gmail::Slack::Notifier::VERSION).not_to be nil
    end

  end

  context 'attributes' do

    it 'has a gmail_client' do
      expect(@notifier.gmail_client).to be_an_instance_of Gmail::Slack::Notifier::GmailClient
    end

    it 'has a slack client' do
      expect(@notifier.slack_client).to be_an_instance_of Gmail::Slack::Notifier::SlackClient
    end

  end

  context 'instance methods' do

    it 'instantiates' do
      expect(@notifier).to be_an_instance_of Gmail::Slack::Notifier
    end

    it 'allows a Gmail client to be set' do
      expect do
        @notifier.gmail_client = Gmail::Slack::Notifier::GmailClient.new
      end.not_to raise_exception
    end
    it 'allows a Slack client to be set' do
      expect do
        @notifier.slack_client = Gmail::Slack::Notifier::SlackClient.new({webhook_url:''})
      end.not_to raise_exception
    end

    it 'should raise if not provided with a GmailClient' do
      [{},'',''.to_sym].each do |item|
        expect do
          @notifier.gmail_client = item
        end.to raise_exception Gmail::Slack::Notifier::Exceptions::GmailClient::Error
      end
    end

    it 'should raise if not provided with a SlackClient' do
      [{},'',''.to_sym].each do |item|
        expect do
          @notifier.slack_client = item
        end.to raise_exception Gmail::Slack::Notifier::Exceptions::SlackClient::Error
      end
    end

    it 'runs' do
      # ToDo: Extend tests here
      expect(@notifier).to respond_to(:run)
    end

  end

end
