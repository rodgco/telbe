module Telbe
  class Bot
    def send_contact(contact_descriptor)
      Message.new(request(:sendContact, contact_descriptor))
    end
  end

  class Contact
    include Virtus.model
    attribute :phone_number, String
    attribute :first_name, String
    attribute :last_name, String
    attribute :user_id, Integer
    attribute :vcard, String
  end

  class ContactDescriptor
    include Virtus.model
    attribute :chat_id, Integer or String
    attribute :phone_number, String
    attribute :first_name, String
    attribute :last_name, String
    attribute :vcard, String
    attribute :disable_notification, Boolean
    attribute :reply_to_message_id, Integer
    attribute :reply_markup, Object #InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply
  end
end
