module Telbe
  class Bot
    def set_webhook(webhook_descriptor)
      request(:setWebhook, webhook_descriptor)
    end

    def delete_webhook
      request(:deleteWebhook)
    end

    def get_webhookinfo
      WebHookInfo.new(request(:getWebhookInfo))
    end
  end
  
  class WebHookInfo
    include Virtus.model
    attribute :url, String
    attribute :has_custom_certificate, Boolean
    attribute :pending_update_count, Integer
    attribute :last_error_date, Integer
    attribute :last_error_message, String
    attribute :max_connections, Integer
    attribute :allowed_updates, Array # of String
  end

  class InputFile
  end
  
  class WebHookDescriptor
    include Virtus.model
    attribute :url, String
    attribute :certificate, InputFile
    attribute :max_connections, Integer
    attribute :allowed_updates, Array # of String
  end
end
