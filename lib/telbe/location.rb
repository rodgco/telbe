module Telbe
  class Bot
    def send_location(send_location_descriptor)
      Message.new(request(:sendLocation, send_location_descriptor))
    end
  end
  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # latitude 	Float number 	Yes 	Latitude of the location
  # longitude 	Float number 	Yes 	Longitude of the location
  # live_period 	Integer 	Optional 	Period in seconds for which the location will be updated (see Live Locations, should be between 60 and 86400.
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply
  class SendLocationDescriptor
    include InitializeFromHash

    def self.factory
      new(
        chat_id: nil,
        latitude: nil,
        longitude: nil,
        liveperiod: 60,
        disable_notification: true,
        reply_to_message_id: nil,
        reply_markup: nil
      )
    end
  end

  # chat_id 	Integer or String 	Optional 	Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # message_id 	Integer 	Optional 	Required if inline_message_id is not specified. Identifier of the message to edit
  # inline_message_id 	String 	Optional 	Required if chat_id and message_id are not specified. Identifier of the inline message
  # latitude 	Float number 	Yes 	Latitude of new location
  # longitude 	Float number 	Yes 	Longitude of new location
  # reply_markup 	InlineKeyboardMarkup 	Optional 	A JSON-serialized object for a new inline keyboard.
  class EditMessageLiveLocationDescriptor
    include InitializeFromHash

    def self.factory
      new(
        chat_id: nil,
        message_id: nil,
        inline_message_id: nil,
        latitude: nil,
        longitude: nil,
        reply_markup:nil
      )
    end
  end
  
  class Location
    include InitializeFromHash
  end

  class Venue
    include InitializeFromHash
  end
end
