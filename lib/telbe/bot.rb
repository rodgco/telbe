module Telbe
  class Bot
    ENDPOINT = 'https://api.telegram.org/'

    def initialize(token:, proxy: nil)
      @token = token
      @proxy = proxy
      @connection = Excon.new(ENDPOINT, persistent: true, proxy: @proxy)
    end

    def request(action, query = {})
      puts "### Telbe::Bot.request #{action} - #{query.to_h}"
      path = "/bot#{@token}/#{action}"
      response = @connection.post(path: path, query: query.to_h)
      if response.status == 200
        puts "### Telbe::Bot.request --- Success"
        body = response.body
        data = JSON.parse(body)
        data["result"]
      else
        puts "### Telbe::Bot.request --- Error"
        raise ResponseError, response.body
      end
    end

    def send_message(message_descriptor)
      Message.new(request(:sendMessage, message_descriptor))
    end

    def get_updates(update_descriptor)
      request(:getUpdates, update_descriptor).collect do |update_hash|
        Update.new(update_hash)
      end
    end

    def get_chat(chatid_descriptor)
      Chat.new(request(:getChat, chatid_descriptor))
    end

    def download_file(file)
      # https://api.telegram.org/file/bot<token>/<file_path>
    end
  end

  class MessageEntity
    include SimplifyApi
  end

  class ForceReply
    include SimplifyApi
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # text 	String 	Yes 	Text of the message to be sent
  # parse_mode 	String 	Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
  # disable_web_page_preview 	Boolean 	Optional 	Disables link previews for links in this message
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class MessageDescriptor
    include SimplifyApi
    attribute :chat_id, Integer, mandatory: true
    attribute :text, String, mandatory: true
    attribute :parse_mode, String, values: ["Markdown", "HTML"]
    attribute :disable_web_page_preview, values: [true, false]
    attribute :reply_to_message_id, Integer
    attribute :reply_markup , Object
  end

  class ChatPhoto
    include SimplifyApi
  end

  class Chat
    include SimplifyApi
  end

  class Message
    include SimplifyApi

    def reply(&block)
      reply = MessageDescriptor.new(chat_id: chat.id)
      yield reply if block_given?
      reply
    end

    def get_command_for(bot)
      text && text.sub(Regexp.new("@#{bot.get_me.username}($|\s|\.|,)", Regexp::IGNORECASE), '').strip
    end
  end

  # update_id 	Integer 	The update‘s unique identifier. Update identifiers start from a certain positive number and increase sequentially. This ID becomes especially handy if you’re using Webhooks, since it allows you to ignore repeated updates or to restore the correct update sequence, should they get out of order. If there are no new updates for at least a week, then identifier of the next update will be chosen randomly instead of sequentially.
  # message 	Message 	Optional. New incoming message of any kind — text, photo, sticker, etc.
  # edited_message 	Message 	Optional. New version of a message that is known to the bot and was edited
  # channel_post 	Message 	Optional. New incoming channel post of any kind — text, photo, sticker, etc.
  # edited_channel_post 	Message 	Optional. New version of a channel post that is known to the bot and was edited
  # inline_query 	InlineQuery 	Optional. New incoming inline query
  # chosen_inline_result 	ChosenInlineResult 	Optional. The result of an inline query that was chosen by a user and sent to their chat partner. Please see our documentation on the feedback collecting for details on how to enable these updates for your bot.
  # callback_query 	CallbackQuery 	Optional. New incoming callback query
  # shipping_query 	ShippingQuery 	Optional. New incoming shipping query. Only for invoices with flexible price
  # pre_checkout_query 	PreCheckoutQuery 	Optional. New incoming pre-checkout query. Contains full information about checkout
  # poll 	Poll 	Optional. New poll state. Bots receive only updates about polls, which are sent or stopped by the bot
  class Update
    include SimplifyApi
    attribute :update_id, Integer, mandatory: true
    attribute :message, Message
    attribute :edited_message, Message
    attribute :channel_post, Message
    attribute :inline_query, InlineQuery
    attribute :chosen_inline_result, ChosenInlineResult
    attribute :callback_query, CallbackQuery
    attribute :poll, Poll
  end

  class UpdateDescriptor
    include SimplifyApi
  end

  class ResponseError < StandardError
    def initialize(msg = "Bot Response Error")
      super
    end
  end
end
