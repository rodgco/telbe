module Telbe
  class Bot
    ENDPOINT = 'https://api.telegram.org/'

    def initialize(token:, proxy: nil)
      @token = token
      @proxy = proxy
      @connection = Excon.new(ENDPOINT, persistent: true, proxy: @proxy)
    end

    def request(action, query = {})
      path = "/bot#{@token}/#{action}"
      response = @connection.post(path: path, query: query.to_h)
      if response.status == 200
        body = response.body
        data = JSON.parse(body)
        data["result"]
      else
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
    include Virtus.model
  end

  class ForceReply
    include Virtus.model
    attribute :force_reply, Boolean
    attribute :selective, Boolean
  end

  class MessageDescriptor
    include Virtus.model
    attribute :chat_id, Object # Integer or String - Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    attribute :text, String 	# Text of the message to be sent
    attribute :parse_mode, String # Optional Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
    attribute :disable_web_page_preview, Boolean # Optional Disables link previews for links in this message
    attribute :disable_notification, Boolean # Optional Sends the message silently. Users will receive a notification with no sound.
    attribute :reply_to_message_id, Integer # Optional If the message is a reply, ID of the original message
    attribute :reply_markup, Object # InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply - Optional Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  end

  class ChatPhoto
    include Virtus.model
    attribute :small_file_id, String
    attribute :big_file_id, String
  end

  class Chat
    include Virtus.model
    attribute :id, Integer
    attribute :type, String
    attribute :title, String
    attribute :username, String
    attribute :first_name, String
    attribute :last_name, String
    attribute :all_members_are_administrators, Boolean
    attribute :photo, ChatPhoto
    attribute :description, String
    attribute :invite_link, String
    attribute :sticker_set_name, String
    attribute :can_set_sticker_set, Boolean
  end

  class Message
    include Virtus.model
    attribute :message_id, Integer
    alias_method :id, :message_id
    alias_method :to_i, :id
    attribute :from, User
    alias_method :user, :from
    attribute :text, String
    attribute :date, DateTime
    attribute :chat, Chat
    attribute :forward_from, User
    attribute :forward_from_chat, Chat
    attribute :forward_from_message_id, Integer
    attribute :forward_signature, String
    attribute :forward_sender_name, String
    attribute :forward_date, Integer
    attribute :reply_to_message, Message
    attribute :edit_date, Integer
    attribute :media_group_id, String
    attribute :author_signature, String
    attribute :text, String
    attribute :entities, Array # of MessageEntity
    attribute :caption_entities, Array # of MessageEntity
    attribute :audio, Audio
    attribute :document, Document
    attribute :animation, Animation
    # attribute :game, Game
    attribute :photo, Array # of PhotoSize
    attribute :sticker, Sticker
    attribute :video, Video
    attribute :voice, Voice
    attribute :video_note, VideoNote
    attribute :caption, String
    attribute :contact, Contact
    attribute :location, Location
    attribute :venue, Venue
    attribute :poll, Poll
    attribute :new_chat_members, Array # of User
    attribute :left_chat_member , User
    attribute :new_chat_title, String
    attribute :new_chat_photo, Array # of PhotoSize
    attribute :delete_chat_photo, Boolean
    attribute :group_chat_created, Boolean
    attribute :supergroup_chat_created, Boolean
    attribute :channel_chat_created, Boolean
    attribute :migrate_to_chat_id, Integer
    attribute :migrate_from_chat_id, Integer
    attribute :pinned_message, Message
    # attribute :invoice, Invoice
    # attribute :successful_payment, SuccessfulPayment
    attribute :connected_website, String
    # attribute :passport_data, PassportData 	

    def reply(&block)
      reply = MessageDescriptor.new(chat_id: chat.id)
      yield reply if block_given?
      reply
    end

    def get_command_for(bot)
      text && text.sub(Regexp.new("@#{bot.get_me.username}($|\s|\.|,)", Regexp::IGNORECASE), '').strip
    end
  end

  class Chat
    attribute :pinned_message, Message
  end

  class Update
    include Virtus.model
    attribute :update_id, Integer
    alias_method :id, :update_id
    alias_method :to_i, :id
    attribute :message, Message
    alias_method :edited_message, :message
    alias_method :channel_post, :message
    alias_method :edited_channel_post, :message
    # attribute :inline_query, InlineQuery
    # attribute :chosen_inline_result, ChosenInlineResult
    # attribute :callback_query, CallbackQuery
    # attribute :shipping_query, ShippingQuery
    # attribute :pre_checkout_query, PreCheckoutQuery
    attribute :poll, Poll
  end

  class UpdateDescriptor
    include Virtus.model
    attribute :offset, Integer
    attribute :limit, Integer
    attribute :timeout, Integer
    attribute :allowed_updates, Array # of String
  end

  class ResponseError < StandardError
    def initialize(msg = "Bot Response Error")
      super
    end
  end
end
