module Telbe
  class Bot
    def answer_callback_query(answer_callback_query_descriptor)
      request(:answerCallbackQuery, answer_callback_query_descriptor)
    end
  end

  # text 	String 	Text of the button. If none of the optional fields are used, it will be sent as a message when the button is pressed
  # request_contact 	Boolean 	Optional. If True, the user's phone number will be sent as a contact when the button is pressed. Available in private chats only
  # request_location 	Boolean 	Optional. If True, the user's current location will be sent when the button is pressed. Available in private chats only
  class KeyboardButton
    include SimplifyApi
    attribute :text, String, mandatory: true
    attribute :request_contact, values: [true, false]
    attribute :request_location, values: [true, false]
  end

  # Created to nest the arrays in ReplyKeyboardMarkup
  class KeyboardButtons
    include SimplifyApi
    attribute :keyboard_button, [KeyboardButton], mandatory: true, invisible: true
  end

  # keyboard 	Array of Array of KeyboardButton 	Array of button rows, each represented by an Array of KeyboardButton objects
  # resize_keyboard 	Boolean 	Optional. Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.
  # one_time_keyboard 	Boolean 	Optional. Requests clients to hide the keyboard as soon as it's been used. The keyboard will still be available, but clients will automatically display the usual letter-keyboard in the chat – the user can press a special button in the input field to see the custom keyboard again. Defaults to false.
  # selective 	Boolean 	Optional. Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
  class ReplyKeyboardMarkup
    include SimplifyApi
    attribute :keyboard, [KeyboardButtons], mandatory: true
    attribute :resize_keyboard, values: [true, false]
    attribute :one_time_keyboard, values: [true, false]
    attribute :selective, values: [true, false]
  end

  class ReplyKeyboardRemove
    include SimplifyApi
  end

  # text 	String 	Label text on the button
  # url 	String 	Optional. HTTP or tg:// url to be opened when button is pressed
  # callback_data 	String 	Optional. Data to be sent in a callback query to the bot when button is pressed, 1-64 bytes
  # switch_inline_query 	String 	Optional. If set, pressing the button will prompt the user to select one of their chats, open that chat and insert the bot‘s username and the specified inline query in the input field. Can be empty, in which case just the bot’s username will be inserted.
  # switch_inline_query_current_chat 	String 	Optional. If set, pressing the button will insert the bot‘s username and the specified inline query in the current chat's input field. Can be empty, in which case only the bot’s username will be inserted.
  # callback_game 	CallbackGame 	Optional. Description of the game that will be launched when the user presses the button.
  # pay 	Boolean 	Optional. Specify True, to send a Pay button.
  class InlineKeyboardButton
    include SimplifyApi
    attribute :text, String, mandatory: true
    attribute :url, String
    attribute :callback_data, String
    attribute :switch_inline_query, String
    attribute :switch_inline_query_current_chat, String
    # attribute :callback_game, CallbackGame
    attribute :pay, values: [true, false]
  end

  # Created to nest the arrays in InlineKeyboardMarkup
  class InlineKeyboardLine
    include SimplifyApi
    attribute :inline_keyboard_buttons, [InlineKeyboardButton], mandatory: true, invisible: true
  end

  # inline_keyboard 	Array of Array of InlineKeyboardButton 	Array of button rows, each represented by an Array of InlineKeyboardButton objects
  class InlineKeyboardMarkup
    include SimplifyApi
    attribute :inline_keyboard, [InlineKeyboardLine], mandatory: true
  end

  # Dummy
  class Message
  end

  # id 	String 	Unique identifier for this query
  # from 	User 	Sender
  # message 	Message 	Optional. Message with the callback button that originated the query. Note that message content and message date will not be available if the message is too old
  # inline_message_id 	String 	Optional. Identifier of the message sent via the bot in inline mode, that originated the query.
  # chat_instance 	String 	Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent. Useful for high scores in games.
  # data 	String 	Optional. Data associated with the callback button. Be aware that a bad client can send arbitrary data in this field.
  # game_short_name 	String 	Optional. Short name of a Game to be returned, serves as the unique identifier for the game
  class CallbackQuery
    include SimplifyApi
    attribute :id, String, mandatory: true
    attribute :from, User, mandatory: true
    attribute :message, Message
    attribute :inline_message_id, String
    attribute :chat_instance, String, mandatory: true
    attribute :data, String
    attribute :game_short_name, String
  end

  # callback_query_id 	String 	Yes 	Unique identifier for the query to be answered
  # text 	String 	Optional 	Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters
  # show_alert 	Boolean 	Optional 	If true, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to false.
  # url 	String 	Optional 	URL that will be opened by the user's client. If you have created a Game and accepted the conditions via @Botfather, specify the URL that opens your game – note that this will only work if the query comes from a callback_game button.
  # cache_time 	Integer 	Optional 	The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to 0.
  class AnswerCallBackQueryDescriptor
    include SimplifyApi
    attribute :callback_query_id, String, mandatory: true
    attribute :text, String
    attribute :show_alert, values: [true, false]
    attribute :url, String
    attribute :cache_time, Integer
  end
end
