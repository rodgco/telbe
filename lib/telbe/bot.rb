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

  class MessageDescriptor
    include InitializeFromHash
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
