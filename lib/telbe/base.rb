module Telbe
  class Descriptor
    def self.inherited(base)
      base.send(:include, SimplifyApi)
      base.send(:attribute, :chat_id, Object, mandatory: true)
      base.send(:attribute, :disable_notification, values: [true, false])
      base.send(:attribute, :reply_to_message_id, Integer)
      base.send(:attribute, :reply_markup, Object)
    end
  end

  class MediaDescriptor < Descriptor
    def self.inherited(base)
      super(base)
      base.send(:attribute, :caption, String)
      base.send(:attribute, :parse_mode, String, values: ["Markdown", "HTML"])
    end
  end

  class InputMedia
    def self.inherited(base)
      base.send(:include, SimplifyApi)
      base.send(:attribute, :type, String, mandatory: true)
      base.send(:attribute, :media, String, mandatory: true)
      base.send(:attribute, :caption, String)
      base.send(:attribute, :parse_mode, String, values: ["Markdown", "HTML"])
    end
  end  
end