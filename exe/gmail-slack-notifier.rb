#!/usr/bin/env ruby

require 'gmail/slack/notifier'

Gmail::Slack::Notifier.new.run!
