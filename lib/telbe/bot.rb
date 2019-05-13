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

    def get_updates(get_updates_descriptor)
      request(:getUpdates, get_updates_descriptor).collect do |update|
        Update.new(update)
      end
    end
  end

  # type 	String 	Type of the entity. Can be mention (@username), hashtag, cashtag, bot_command, url, email, phone_number, bold (bold text), italic (italic text), code (monowidth string), pre (monowidth block), text_link (for clickable text URLs), text_mention (for users without usernames)
  # offset 	Integer 	Offset in UTF-16 code units to the start of the entity
  # length 	Integer 	Length of the entity in UTF-16 code units
  # url 	String 	Optional. For “text_link” only, url that will be opened after user taps on the text
  # user 	User 	Optional. For “text_mention” only, the mentioned user
  class MessageEntity
    include SimplifyApi
    attribute :type, String, mandatory: true
    attribute :offset, Integer, mandatory: true
    attribute :length, Integer, mandatory: true
    attribute :url, String
    attribute :user, User   
  end

  # force_reply 	True 	Shows reply interface to the user, as if they manually selected the bot‘s message and tapped ’Reply'
  # selective 	Boolean 	Optional. Use this parameter if you want to force reply from specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
  class ForceReply
    include SimplifyApi
    attribute :force_reply, values: [true], mandatory: true
    attribute :selective, values: [true, false]
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

  # message_id 	Integer 	Unique message identifier inside this chat
  # from 	User 	Optional. Sender, empty for messages sent to channels
  # date 	Integer 	Date the message was sent in Unix time
  # chat 	Chat 	Conversation the message belongs to
  # forward_from 	User 	Optional. For forwarded messages, sender of the original message
  # forward_from_chat 	Chat 	Optional. For messages forwarded from channels, information about the original channel
  # forward_from_message_id 	Integer 	Optional. For messages forwarded from channels, identifier of the original message in the channel
  # forward_signature 	String 	Optional. For messages forwarded from channels, signature of the post author if present
  # forward_sender_name 	String 	Optional. Sender's name for messages forwarded from users who disallow adding a link to their account in forwarded messages
  # forward_date 	Integer 	Optional. For forwarded messages, date the original message was sent in Unix time
  # reply_to_message 	Message 	Optional. For replies, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
  # edit_date 	Integer 	Optional. Date the message was last edited in Unix time
  # media_group_id 	String 	Optional. The unique identifier of a media message group this message belongs to
  # author_signature 	String 	Optional. Signature of the post author for messages in channels
  # text 	String 	Optional. For text messages, the actual UTF-8 text of the message, 0-4096 characters.
  # entities 	Array of MessageEntity 	Optional. For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
  # caption_entities 	Array of MessageEntity 	Optional. For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption
  # audio 	Audio 	Optional. Message is an audio file, information about the file
  # document 	Document 	Optional. Message is a general file, information about the file
  # animation 	Animation 	Optional. Message is an animation, information about the animation. For backward compatibility, when this field is set, the document field will also be set
  # game 	Game 	Optional. Message is a game, information about the game. More about games »
  # photo 	Array of PhotoSize 	Optional. Message is a photo, available sizes of the photo
  # sticker 	Sticker 	Optional. Message is a sticker, information about the sticker
  # video 	Video 	Optional. Message is a video, information about the video
  # voice 	Voice 	Optional. Message is a voice message, information about the file
  # video_note 	VideoNote 	Optional. Message is a video note, information about the video message
  # caption 	String 	Optional. Caption for the animation, audio, document, photo, video or voice, 0-1024 characters
  # contact 	Contact 	Optional. Message is a shared contact, information about the contact
  # location 	Location 	Optional. Message is a shared location, information about the location
  # venue 	Venue 	Optional. Message is a venue, information about the venue
  # poll 	Poll 	Optional. Message is a native poll, information about the poll
  # new_chat_members 	Array of User 	Optional. New members that were added to the group or supergroup and information about them (the bot itself may be one of these members)
  # left_chat_member 	User 	Optional. A member was removed from the group, information about them (this member may be the bot itself)
  # new_chat_title 	String 	Optional. A chat title was changed to this value
  # new_chat_photo 	Array of PhotoSize 	Optional. A chat photo was change to this value
  # delete_chat_photo 	True 	Optional. Service message: the chat photo was deleted
  # group_chat_created 	True 	Optional. Service message: the group has been created
  # supergroup_chat_created 	True 	Optional. Service message: the supergroup has been created. This field can‘t be received in a message coming through updates, because bot can’t be a member of a supergroup when it is created. It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.
  # channel_chat_created 	True 	Optional. Service message: the channel has been created. This field can‘t be received in a message coming through updates, because bot can’t be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.
  # migrate_to_chat_id 	Integer 	Optional. The group has been migrated to a supergroup with the specified identifier. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
  # migrate_from_chat_id 	Integer 	Optional. The supergroup has been migrated from a group with the specified identifier. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
  # pinned_message 	Message 	Optional. Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it is itself a reply.
  # invoice 	Invoice 	Optional. Message is an invoice for a payment, information about the invoice. More about payments »
  # successful_payment 	SuccessfulPayment 	Optional. Message is a service message about a successful payment, information about the payment. More about payments »
  # connected_website 	String 	Optional. The domain name of the website on which the user has logged in. More about Telegram Login »
  # passport_data 	PassportData 	Optional. Telegram Passport data
  class Message
    include SimplifyApi
    attribute :message_id, Integer, mandatory: true
    attribute :from, User
    attribute :date, Integer, mandatory: true
    attribute :chat, Chat, mandatory: true
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
    attribute :entities, [MessageEntity]
    attribute :caption_entities, [MessageEntity]
    attribute :audio, Audio
    attribute :document, Document
    attribute :animation, Animation
    # attribute :game, Game
    attribute :photo, [PhotoSize]
    attribute :sticker, Sticker
    attribute :video, Video
    attribute :voice, Voice
    attribute :video_note, VideoNote
    attribute :caption, String
    attribute :contact, Contact
    attribute :location, Location
    attribute :venue, Venue
    attribute :poll, Poll
    attribute :new_chat_members, [User]
    attribute :left_chat_member, User
    attribute :new_chat_title, String
    attribute :new_chat_photo, [PhotoSize]
    attribute :delete_chat_photo, values: [true]
    attribute :group_chat_created, values: [true]
    attribute :supergroup_chat_created, values: [true]
    attribute :channel_chat_created, values: [true]
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

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # from_chat_id 	Integer or String 	Yes 	Unique identifier for the chat where the original message was sent (or channel username in the format @channelusername)
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # message_id 	Integer 	Yes 	Message identifier in the chat specified in from_chat_id
  class ForwardMessageDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :from_chat_id, Object, mandatory: true
    attribute :disable_notification, values: [true, false]
    attribute :message_id, Integer, mandatory: true
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

  # offset 	Integer 	Optional 	Identifier of the first update to be returned. Must be greater by one than the highest among the identifiers of previously received updates. By default, updates starting with the earliest unconfirmed update are returned. An update is considered confirmed as soon as getUpdates is called with an offset higher than its update_id. The negative offset can be specified to retrieve updates starting from -offset update from the end of the updates queue. All previous updates will forgotten.
  # limit 	Integer 	Optional 	Limits the number of updates to be retrieved. Values between 1—100 are accepted. Defaults to 100.
  # timeout 	Integer 	Optional 	Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling. Should be positive, short polling should be used for testing purposes only.
  # allowed_updates 	Array of String 	Optional 	List the types of updates you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all updates regardless of type (default). If not specified, the previous setting will be used.
  class GetUpdatesDescriptor
    include SimplifyApi
    attribute :offset, Integer
    attribute :limit, Integer
    attribute :timeout, Integer
    attribute :allowed_updates, [String]
  end

  class ResponseError < StandardError
    def initialize(msg = "Bot Response Error")
      super
    end
  end
end
