require 'excon'
require 'virtus'
require 'json'

require 'telbe/webhook'
require 'telbe/user'
require 'telbe/contact'
require 'telbe/keyboard'
require 'telbe/poll'
require 'telbe/media'
require 'telbe/sticker'
require 'telbe/location'
require 'telbe/bot'

module BotEngine
  def self.new(opts)
    Bot.new(opts)
  end
end