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

    def get_me
      User.new(request(:getMe))
    end

    def get_chat(chatid_descriptor)
      Chat.new(request(:getChat, chatid_descriptor))
    end

    def download_file(file)
      # https://api.telegram.org/file/bot<token>/<file_path>
    end
  end

  class MessageEntity
    include InitializeFromHash
  end

  class ForceReply
    include InitializeFromHash
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # text 	String 	Yes 	Text of the message to be sent
  # parse_mode 	String 	Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
  # disable_web_page_preview 	Boolean 	Optional 	Disables link previews for links in this message
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class MessageDescriptor
    include InitializeFromHash
    def self.factory
      new(
        chat_id: nil,
        text: "",
        parse_mode: "", # Markdown or HTML
        disable_web_page_preview: false,
        disable_notification: false,
        reply_to_message_id: nil,
        reply_markup: nil
      )
    end

    def initialize(opts)
      raise ArgumentError, 'Invalid parse_mode' unless valid_parse_mode? opts[:parse_mode]
      super opts
    end

    def parse_mode= (value)
      value ||= "" # cast nil to the empty string
      raise ArgumentError, 'Invalid parse_mode' unless valid_parse_mode? value
      @parse_mode = value
    end

    private
    def valid_parse_mode? (value)
      value =~ /(^Markdown$)|(^HTML$)|(^$)/ # 0 = true
    end
  end

  class ChatPhoto
    include InitializeFromHash
  end

  class Chat
    include InitializeFromHash
  end

  class Message
    include InitializeFromHash

    def reply(&block)
      reply = MessageDescriptor.new(chat_id: chat.id)
      yield reply if block_given?
      reply
    end

    def get_command_for(bot)
      text && text.sub(Regexp.new("@#{bot.get_me.username}($|\s|\.|,)", Regexp::IGNORECASE), '').strip
    end
  end

  class Update
    include InitializeFromHash
  end

  class UpdateDescriptor
    include InitializeFromHash
  end

  class ResponseError < StandardError
    def initialize(msg = "Bot Response Error")
      super
    end
  end
end
