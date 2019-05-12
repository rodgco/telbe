module Telbe
  class Bot
    def send_poll(poll_descriptor)
      Message.new(request(:sendPoll, poll_descriptor))
    end
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername). A native poll can't be sent to a private chat.
  # question 	String 	Yes 	Poll question, 1-255 characters
  # options 	Array of String 	Yes 	List of answer options, 2-10 strings 1-100 characters each
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class PollDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true # Integer or String
    attribute :question, String, mandatory: true
    attribute :options, [String], mandatory: true # 2-10 strings 1-100 characters each
    attribute :disable_notification, values: [true, false]
    attribute :reply_to_message_id, Integer
    attribute :reply_markup, Object
  end

  class PollOption
    include SimplifyApi
  end

  class Poll
    include SimplifyApi
  end
end
