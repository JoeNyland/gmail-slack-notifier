require 'spec_helper'

describe Hash do
  context '#format_as_slack_message' do
    before do
      @example_hash = {
          from: 'John',
          subject: 'Ow Do!',
          date: Time.now
      }
    end
    it 'should not error when provided with a valid Hash' do
      expect { @formatted_string = @example_hash.format_as_slack_message }.to_not raise_exception
    end

    it 'should successfully convert a hash to a formatted string' do
      @formatted_string = @example_hash.format_as_slack_message
      expect(@formatted_string).to eq "From: #{@example_hash[:from]}\nSubject: #{@example_hash[:subject]}\nDate: #{@example_hash[:date]}"
    end
  end
end
