module Telbe
  class Bot
    def send_location(send_location_descriptor)
      Message.new(request(:sendLocation, send_location_descriptor))
    end

    def edit_message_live_location(edit_message_live_location_descriptor)
      Message.new(request(:editMessageLiveLocation, edit_message_live_location_descriptor))
    end

    def stop_message_live_location(stop_message_live_location_descriptor)
      Message.new(request(:stopMessageLiveLocation, stop_message_live_location_descriptor))
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
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true # Integer or String
    attribute :latitude, Float, mandatory: true
    attribute :longitude, Float, mandatory: true
    attribute :live_period, Integer
    attribute :disable_notification, values: [true, false]
    attribute :reply_to_message_id, Integer
    attribute :reply_markup, Object
  end

  # chat_id 	Integer or String 	Optional 	Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # message_id 	Integer 	Optional 	Required if inline_message_id is not specified. Identifier of the message to edit
  # inline_message_id 	String 	Optional 	Required if chat_id and message_id are not specified. Identifier of the inline message
  # latitude 	Float number 	Yes 	Latitude of new location
  # longitude 	Float number 	Yes 	Longitude of new location
  # reply_markup 	InlineKeyboardMarkup 	Optional 	A JSON-serialized object for a new inline keyboard.
  class EditMessageLiveLocationDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true # Integer or String
    attribute :message_id, Integer
    attribute :inline_message_id, String
    attribute :latitude, Float, mandatory: true
    attribute :longitude, Float, mandatory: true
    attribute :reply_markup, Object
  end

  # chat_id 	Integer or String 	Optional 	Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # message_id 	Integer 	Optional 	Required if inline_message_id is not specified. Identifier of the message with live location to stop
  # inline_message_id 	String 	Optional 	Required if chat_id and message_id are not specified. Identifier of the inline message
  # reply_markup 	InlineKeyboardMarkup 	Optional 	A JSON-serialized object for a new inline keyboard.
  class StopMessageLivaLocationDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true # Integer or String
    attribute :message_id, Integer
    attribute :inline_message_id, String
    attribute :reply_markup, Object
  end
  
  # longitude 	Float 	Longitude as defined by sender
  # latitude 	Float 	Latitude as defined by sender
  class Location
    include SimplifyApi
    attribute :longitude, Float, mandatory: true
    attribute :latitude, Float, mandatory: true
  end

  # location 	Location 	Venue location
  # title 	String 	Name of the venue
  # address 	String 	Address of the venue
  # foursquare_id 	String 	Optional. Foursquare identifier of the venue
  # foursquare_type 	String 	Optional. Foursquare type of the venue. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
  class Venue
    include SimplifyApi
    attribute :location, Location, mandatory: true
    attribute :title, String, mandatory: true
    attribute :address, String, mandatory: true
    attribute :foursquare_id, String
    attribute :foursquare_type, String
  end
end
