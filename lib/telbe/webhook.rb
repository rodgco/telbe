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
    include InitializeFromHash
  end

  class InputFile
    include InitializeFromHash
  end
  
  class WebHookDescriptor
    include InitializeFromHash
  end
end
