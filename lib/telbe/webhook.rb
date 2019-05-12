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
  
  # url 	String 	Webhook URL, may be empty if webhook is not set up
  # has_custom_certificate 	Boolean 	True, if a custom certificate was provided for webhook certificate checks
  # pending_update_count 	Integer 	Number of updates awaiting delivery
  # last_error_date 	Integer 	Optional. Unix time for the most recent error that happened when trying to deliver an update via webhook
  # last_error_message 	String 	Optional. Error message in human-readable format for the most recent error that happened when trying to deliver an update via webhook
  # max_connections 	Integer 	Optional. Maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery
  # allowed_updates 	Array of String 	Optional. A list of update types the bot is subscribed to. Defaults to all update types
  class WebHookInfo
    include SimplifyApi
    attribute :url, String, mandatory: true
    attribute :has_custom_certificate, values: [true, false]
    attribute :pending_update_count, Integer, mandatory: true
    attribute :last_error_date, Integer
    attribute :last_error_message, String
    attribute :max_connections, Integer
    attribute :allowed_updates, [String]
  end

  # url 	String 	Yes 	HTTPS url to send updates to. Use an empty string to remove webhook integration
  # certificate 	InputFile 	Optional 	Upload your public key certificate so that the root certificate in use can be checked. See our self-signed guide for details.
  # max_connections 	Integer 	Optional 	Maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery, 1-100. Defaults to 40. Use lower values to limit the load on your bot‘s server, and higher values to increase your bot’s throughput.
  # allowed_updates 	Array of String 	Optional 	List the types of updates you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all updates regardless of type (default). If not specified, the previous setting will be used.
  class WebHookDescriptor
    include SimplifyApi
    attribute :url, String, mandatory: true
    attribute :certificate, InputFile
    attribute :max_connections, Integer
    attribute :allowed_updates, [String]
  end
end
