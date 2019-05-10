module Telbe
  # text 	String 	Text of the button. If none of the optional fields are used, it will be sent as a message when the button is pressed
  # request_contact 	Boolean 	Optional. If True, the user's phone number will be sent as a contact when the button is pressed. Available in private chats only
  # request_location 	Boolean 	Optional. If True, the user's current location will be sent when the button is pressed. Available in private chats only
  class KeyboardButton
    include InitializeFromHash
    def self.factory
      self.new(
        text: "",
        request_contact: false,
        request_location: false
      )
    end
  end

  class ReplyKeyboardRemove
    include InitializeFromHash
  end

  # keyboard 	Array of Array of KeyboardButton 	Array of button rows, each represented by an Array of KeyboardButton objects
  # resize_keyboard 	Boolean 	Optional. Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.
  # one_time_keyboard 	Boolean 	Optional. Requests clients to hide the keyboard as soon as it's been used. The keyboard will still be available, but clients will automatically display the usual letter-keyboard in the chat – the user can press a special button in the input field to see the custom keyboard again. Defaults to false.
  # selective 	Boolean 	Optional. Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
  class ReplyKeyboardMarkup
    include InitializeFromHash
    def self.factory
      self.new(
        keyboard: [[]],
        resize_keyboard: true,
        one_time_keyboard: true,
        selective: false
      )
    end
  end

  class InlineKeyboardMarkup
    include InitializeFromHash
  end

  class InlineKeyboardButton
    include InitializeFromHash
  end
end
