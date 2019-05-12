module Telbe
  class Bot
    def send_contact(contact_descriptor)
      Message.new(request(:sendContact, contact_descriptor))
    end
  end

  # phone_number 	String 	Contact's phone number
  # first_name 	String 	Contact's first name
  # last_name 	String 	Optional. Contact's last name
  # user_id 	Integer 	Optional. Contact's user identifier in Telegram
  # vcard 	String 	Optional. Additional data about the contact in the form of a vCard
  class Contact
    include SimplifyApi
    attribute :phone_number, String, mandatory: true
    attribute :first_name, String, mandatory: true
    attribute :last_name, String
    attribute :user_id, Integer
    attribute :vcard, String
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # phone_number 	String 	Yes 	Contact's phone number
  # first_name 	String 	Yes 	Contact's first name
  # last_name 	String 	Optional 	Contact's last name
  # vcard 	String 	Optional 	Additional data about the contact in the form of a vCard, 0-2048 bytes
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove keyboard or to force a reply from the user.
  class ContactDescriptor < Descriptor
    include SimplifyApi
    attribute :phone_number, String, mandatory: true
    attribute :first_name, String, mandatory: true
    attribute :last_name, String
    attribute :vcard, String
  end
end
