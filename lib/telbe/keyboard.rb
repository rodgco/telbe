module Telbe
  class KeyboardButton
    include Virtus.model
    attribute :text, String
    attribute :request_contact, Boolean
    attribute :request_location, Boolean
  end

  class ReplyKeyboardRemove
    include Virtus.model
    attribute :remove_keyboard, Boolean
    attribute :selective, Boolean
  end

  class ReplyKeyboardMarkup
    include Virtus.model
    attribute :keyboard, Array # of Array of KeyboardButton
    attribute :resize_keyboard, Boolean
    attribute :one_time_keyboard, Boolean
    attribute :selective, Boolean
  end

  class InlineKeyboardMarkup
    include Virtus.model
    attribute :inline_keyboard, Array # of Array of InlineKeyboardButton
  end

  class InlineKeyboardButton
    include Virtus.model
    attribute :text, String
    attribute :url, String
    attribute :callback_data, String
    attribute :switch_inline_query, String
    attribute :switch_inline_query_current_chat, String
    # attribute :callback_game, CallbackGame
    # attribute :pay, Boolean
  end
end
