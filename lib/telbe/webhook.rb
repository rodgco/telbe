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
    include SimplifyApi
  end

  class InputFile
    include SimplifyApi
  end
  
  class WebHookDescriptor
    include SimplifyApi
  end
end
