module Telbe
  class Descriptor
    def self.inherited(base)
      base.send(:include, SimplifyApi)
      base.send(:attribute, :chat_id, Object, mandatory: true)
      base.send(:attribute, :disable_notification, values: [true, false], default: false)
      base.send(:attribute, :reply_to_message_id, Integer)
      base.send(:attribute, :reply_markup, Object)
    end
  end

  class MediaDescriptor < Descriptor
    def self.inherited(base)
      super(base)
      base.send(:attribute, :caption, String)
      base.send(:attribute, :parse_mode, String, values: %w[Markdown HTML], default: 'Markdown')
    end
  end

  class InputMedia
    def self.inherited(base)
      base.send(:include, SimplifyApi)
      base.send(:attribute, :type, String, mandatory: true)
      base.send(:attribute, :media, String, mandatory: true)
      base.send(:attribute, :caption, String)
      base.send(:attribute, :parse_mode, String, values: %w[Markdown HTML], default: 'Markdown')
    end
  end

  class InlineQueryResult
    def self.inherited(base)
      base.send(:include, SimplifyApi)
      base.send(:attribute, :type, String, mandatory: true)
      base.send(:attribute, :id, String, mandatory: true)
      base.send(:attribute, :caption, String)
      base.send(:attribute, :parse_mode, String, values: %w[Markdown HTML], default: 'Markdown')
      base.send(:attribute, :reply_markup, InlineKeyboardMarkup)
      base.send(:attribute, :input_message_content, Object)
    end
  end
end