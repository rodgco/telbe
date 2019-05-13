module Telbe
  class Bot
    def answer_inline_query(answer_inline_query_descriptor)
      request(:answerInlineQuery, answer_inline_query_descriptor)
    end
  end

  # id 	String 	Unique identifier for this query
  # from 	User 	Sender
  # location 	Location 	Optional. Sender location, only for bots that request user location
  # query 	String 	Text of the query (up to 512 characters)
  # offset 	String 	Offset of the results to be returned, can be controlled by the bot
  class InlineQuery
    include SimplifyApi
    attribute :id, String
    attribute :from, User
    attribute :location, Location
    attribute :query, String
    attribute :offset, String
  end

  # inline_query_id 	String 	Yes 	Unique identifier for the answered query
  # results 	Array of InlineQueryResult 	Yes 	A JSON-serialized array of results for the inline query
  # cache_time 	Integer 	Optional 	The maximum amount of time in seconds that the result of the inline query may be cached on the server. Defaults to 300.
  # is_personal 	Boolean 	Optional 	Pass True, if results may be cached on the server side only for the user that sent the query. By default, results may be returned to any user who sends the same query
  # next_offset 	String 	Optional 	Pass the offset that a client should send in the next query with the same text to receive more results. Pass an empty string if there are no more results or if you don‘t support pagination. Offset length can’t exceed 64 bytes.
  # switch_pm_text 	String 	Optional 	If passed, clients will display a button with specified text that switches the user to a private chat with the bot and sends the bot a start message with the parameter switch_pm_parameter
  # switch_pm_parameter 	String 	Optional 	Deep-linking parameter for the /start message sent to the bot when user presses the switch button. 1-64 characters, only A-Z, a-z, 0-9, _ and - are allowed.
  class AnswerInlineQueryDescriptor
    include SimplifyApi
    attribute :inline_query_id, String, mandatory: true
    attribute :results, [Object], mandatory: true
    attribute :cache_time, Integer
    attribute :is_personal, values: [true, false]
    attribute :next_offset, String
    attribute :switch_pm_text, String
    attribute :switch_pm_parameter, String
  end

  # result_id 	String 	The unique identifier for the result that was chosen
  # from 	User 	The user that chose the result
  # location 	Location 	Optional. Sender location, only for bots that require user location
  # inline_message_id 	String 	Optional. Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message. Will be also received in callback queries and can be used to edit the message.
  # query 	String 	The query that was used to obtain the result
  class ChosenInlineResult
    include SimplifyApi
    attribute :result_id, String, mandatory: true
    attribute :from, User, mandatory: true
    attribute :location, Location
    attribute :inline_message_id, String
    attribute :query, String, mandatory: true
  end

  # type 	String 	Type of the result, must be audio
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # audio_file_id 	String 	A valid file identifier for the audio file
  # caption 	String 	Optional. Caption, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the audio
  class InlineQueryResultCachedAudio < InlineQueryResult
    attribute :audio_file_id, String, mandatory: true
  end

  # type 	String 	Type of the result, must be document
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # title 	String 	Title for the result
  # document_file_id 	String 	A valid file identifier for the file
  # description 	String 	Optional. Short description of the result
  # caption 	String 	Optional. Caption of the document to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the file
  class InlineQueryResultCachedDocument < InlineQueryResult
    attribute :title, String, mandatory: true
    attribute :document_file_id, String, mandatory: true
    attribute :description, String
  end

  # type 	String 	Type of the result, must be gif
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # gif_file_id 	String 	A valid file identifier for the GIF file
  # title 	String 	Optional. Title for the result
  # caption 	String 	Optional. Caption of the GIF file to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the GIF animation
  class InlineQueryResultCachedGif < InlineQueryResult
    attribute :gif_file_id, String, mandatory: true
    attribute :title, String
  end

  # type 	String 	Type of the result, must be mpeg4_gif
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # mpeg4_file_id 	String 	A valid file identifier for the MP4 file
  # title 	String 	Optional. Title for the result
  # caption 	String 	Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the video animation
  class InlineQueryResultCachedMpeg4Gif < InlineQueryResult
    attribute :mpeg4_file_id, String, mandatory: true
    attribute :title, String
  end

  # type 	String 	Type of the result, must be photo
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # photo_file_id 	String 	A valid file identifier of the photo
  # title 	String 	Optional. Title for the result
  # description 	String 	Optional. Short description of the result
  # caption 	String 	Optional. Caption of the photo to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the photo
  class InlineQueryResultCachedPhoto < InlineQueryResult
    attribute :photo_file_id, String, mandatory: true
    attribute :title, String
    attribute :description, String
  end

  # type 	String 	Type of the result, must be sticker
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # sticker_file_id 	String 	A valid file identifier of the sticker
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the sticker
  class InlineQueryResultCachedSticker < InlineQueryResult
    attribute :sticker_file_id, String, mandatory: true
  end

  # type 	String 	Type of the result, must be video
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # video_file_id 	String 	A valid file identifier for the video file
  # title 	String 	Title for the result
  # description 	String 	Optional. Short description of the result
  # caption 	String 	Optional. Caption of the video to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the video
  class InlineQueryResultCachedVideo < InlineQueryResult
    attribute :video_file_id, String, mandatory: true
    attribute :title, String, mandatory: true
    attribute :description, String
  end

  # type 	String 	Type of the result, must be voice
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # voice_file_id 	String 	A valid file identifier for the voice message
  # title 	String 	Voice message title
  # caption 	String 	Optional. Caption, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the voice message
  class InlineQueryResultCachedVoice < InlineQueryResult
    attribute :voice_file_id, String, mandatory: true
    attribute :title, String, mandatory: true
  end

  # type 	String 	Type of the result, must be article
  # id 	String 	Unique identifier for this result, 1-64 Bytes
  # title 	String 	Title of the result
  # input_message_content 	InputMessageContent 	Content of the message to be sent
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # url 	String 	Optional. URL of the result
  # hide_url 	Boolean 	Optional. Pass True, if you don't want the URL to be shown in the message
  # description 	String 	Optional. Short description of the result
  # thumb_url 	String 	Optional. Url of the thumbnail for the result
  # thumb_width 	Integer 	Optional. Thumbnail width
  # thumb_height 	Integer 	Optional. Thumbnail height
  class InlineQueryResultArticle < InlineQueryResult
    attribute :title, String, mandatory: true
    attribute :input_message_content, InputMessageContent, mandatory: true
    attribute :url, String
    attribute :hide_url, values: [true, false]
    attribute :description, String
    attribute :thumb_url, String
    attribute :thumb_width, Integer
    attribute :thumb_height, Integer
  end

  # type 	String 	Type of the result, must be audio
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # audio_url 	String 	A valid URL for the audio file
  # title 	String 	Title
  # caption 	String 	Optional. Caption, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # performer 	String 	Optional. Performer
  # audio_duration 	Integer 	Optional. Audio duration in seconds
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the audio
  class InlineQueryResultAudio < InlineQueryResult
    attribute :audio_url, String, mandatory: true
    attribute :title, String, mandatory: true
    attribute :performer, String
    attribute :audio_duration, Integer
  end

  # type 	String 	Type of the result, must be contact
  # id 	String 	Unique identifier for this result, 1-64 Bytes
  # phone_number 	String 	Contact's phone number
  # first_name 	String 	Contact's first name
  # last_name 	String 	Optional. Contact's last name
  # vcard 	String 	Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the contact
  # thumb_url 	String 	Optional. Url of the thumbnail for the result
  # thumb_width 	Integer 	Optional. Thumbnail width
  # thumb_height 	Integer 	Optional. Thumbnail height
  class InlineQueryResultContact < InlineQueryResult
    attribute :phone_number, String, mandatory: true
    attribute :first_name, String, mandatory: true
    attribute :last_name, String
    attribute :vcard, String
    attribute :thumb_url, String
    attribute :thumb_width, Integer
    attribute :thumb_height, Integer
  end

  # type 	String 	Type of the result, must be game
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # game_short_name 	String 	Short name of the game
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  class InlineQueryResultGame < InlineQueryResult
    attribute :game_short_name, String, mandatory: true
  end

  # type 	String 	Type of the result, must be document
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # title 	String 	Title for the result
  # caption 	String 	Optional. Caption of the document to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # document_url 	String 	A valid URL for the file
  # mime_type 	String 	Mime type of the content of the file, either “application/pdf” or “application/zip”
  # description 	String 	Optional. Short description of the result
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the file
  # thumb_url 	String 	Optional. URL of the thumbnail (jpeg only) for the file
  # thumb_width 	Integer 	Optional. Thumbnail width
  # thumb_height 	Integer 	Optional. Thumbnail height
  class InlineQueryResultDocument < InlineQueryResult
    attribute :title, String, mandatory: true
    attribute :document_url, String, mandatory: true
    attribute :mime_type, String, mandatory: true
    attribute :description, String
    attribute :thumb_url, String
    attribute :thumb_width, Integer
    attribute :thumb_height, Integer
  end

  # type 	String 	Type of the result, must be gif
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # gif_url 	String 	A valid URL for the GIF file. File size must not exceed 1MB
  # gif_width 	Integer 	Optional. Width of the GIF
  # gif_height 	Integer 	Optional. Height of the GIF
  # gif_duration 	Integer 	Optional. Duration of the GIF
  # thumb_url 	String 	URL of the static thumbnail for the result (jpeg or gif)
  # title 	String 	Optional. Title for the result
  # caption 	String 	Optional. Caption of the GIF file to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the GIF animation
  class InlineQueryResultGif < InlineQueryResult
    attribute :gif_url, String, mandatory: true
    attribute :gif_width, Integer
    attribute :gif_height, Integer
    attribute :gif_duration, Integer
    attribute :thumb_url, String, mandatory: true
    attribute :title, String
  end

  # type 	String 	Type of the result, must be location
  # id 	String 	Unique identifier for this result, 1-64 Bytes
  # latitude 	Float number 	Location latitude in degrees
  # longitude 	Float number 	Location longitude in degrees
  # title 	String 	Location title
  # live_period 	Integer 	Optional. Period in seconds for which the location can be updated, should be between 60 and 86400.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the location
  # thumb_url 	String 	Optional. Url of the thumbnail for the result
  # thumb_width 	Integer 	Optional. Thumbnail width
  # thumb_height 	Integer 	Optional. Thumbnail height
  class InlineQueryResultLocation < InlineQueryResult
    attribute :latitude, Float, mandatory: true
    attribute :longitude, Float, mandatory: true
    attribute :title, String, mandatory: true
    attribute :live_period, Integer
    attribute :thumb_url, String
    attribute :thumb_width, Integer
    attribute :thumb_height, Integer
  end

  # type 	String 	Type of the result, must be mpeg4_gif
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # mpeg4_url 	String 	A valid URL for the MP4 file. File size must not exceed 1MB
  # mpeg4_width 	Integer 	Optional. Video width
  # mpeg4_height 	Integer 	Optional. Video height
  # mpeg4_duration 	Integer 	Optional. Video duration
  # thumb_url 	String 	URL of the static thumbnail (jpeg or gif) for the result
  # title 	String 	Optional. Title for the result
  # caption 	String 	Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the video animation
  class InlineQueryResultMpeg4Gif < InlineQueryResult
    attribute :mpeg4_url, String, mandatory: true
    attribute :mpeg4_width, Integer
    attribute :mpeg4_height, Integer
    attribute :mpeg4_duration, Integer
    attribute :thumb_url, String, mandatory: true
    attribute :title, String
  end

  # type 	String 	Type of the result, must be photo
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # photo_url 	String 	A valid URL of the photo. Photo must be in jpeg format. Photo size must not exceed 5MB
  # thumb_url 	String 	URL of the thumbnail for the photo
  # photo_width 	Integer 	Optional. Width of the photo
  # photo_height 	Integer 	Optional. Height of the photo
  # title 	String 	Optional. Title for the result
  # description 	String 	Optional. Short description of the result
  # caption 	String 	Optional. Caption of the photo to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the photo
  class InlineQueryResultPhoto < InlineQueryResult
    attribute :photo_url, String, mandatory: true
    attribute :thumb_url, String, mandatory: true
    attribute :photo_width, Integer
    attribute :photo_height, Integer
    attribute :title, String
    attribute :description, String
  end

  # type 	String 	Type of the result, must be venue
  # id 	String 	Unique identifier for this result, 1-64 Bytes
  # latitude 	Float 	Latitude of the venue location in degrees
  # longitude 	Float 	Longitude of the venue location in degrees
  # title 	String 	Title of the venue
  # address 	String 	Address of the venue
  # foursquare_id 	String 	Optional. Foursquare identifier of the venue if known
  # foursquare_type 	String 	Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the venue
  # thumb_url 	String 	Optional. Url of the thumbnail for the result
  # thumb_width 	Integer 	Optional. Thumbnail width
  # thumb_height 	Integer 	Optional. Thumbnail height
  class InlineQueryResultVenue < InlineQueryResult
    attribute :latitude, Float, mandatory: true
    attribute :longitude, Float, mandatory: true
    attribute :title, String, mandatory: true
    attribute :address, String, mandatory: true
    attribute :foursquare_id, String
    attribute :foursquare_type, String
    attribute :thumb_url, String
    attribute :thumb_width, Integer
    attribute :thumb_height, Integer
  end

  # type 	String 	Type of the result, must be video
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # video_url 	String 	A valid URL for the embedded video player or video file
  # mime_type 	String 	Mime type of the content of video url, “text/html” or “video/mp4”
  # thumb_url 	String 	URL of the thumbnail (jpeg only) for the video
  # title 	String 	Title for the result
  # caption 	String 	Optional. Caption of the video to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # video_width 	Integer 	Optional. Video width
  # video_height 	Integer 	Optional. Video height
  # video_duration 	Integer 	Optional. Video duration in seconds
  # description 	String 	Optional. Short description of the result
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the video. This field is required if InlineQueryResultVideo is used to send an HTML-page as a result (e.g., a YouTube video).
  class InlineQueryResultVideo < InlineQueryResult
    attribute :video_url, String, mandatory: true
    attribute :mime_type, String, mandatory: true
    attribute :thumb_url, String, mandatory: true
    attribute :title, String, mandatory: true
    attribute :video_width, Integer
    attribute :video_height, Integer
    attribute :video_duration, Integer
    attribute :description, String
  end

  # type 	String 	Type of the result, must be voice
  # id 	String 	Unique identifier for this result, 1-64 bytes
  # voice_url 	String 	A valid URL for the voice recording
  # title 	String 	Recording title
  # caption 	String 	Optional. Caption, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # voice_duration 	Integer 	Optional. Recording duration in seconds
  # reply_markup 	InlineKeyboardMarkup 	Optional. Inline keyboard attached to the message
  # input_message_content 	InputMessageContent 	Optional. Content of the message to be sent instead of the voice recording
  class InlineQueryResultVoice < InlineQueryResult
    attribute :voice_url, String, mandatory: true
    attribute :title, String, mandatory: true
    attribute :voice_duration, Integer
  end

  # message_text 	String 	Text of the message to be sent, 1-4096 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
  # disable_web_page_preview 	Boolean 	Optional. Disables link previews for links in the sent message
  class InputMessageContent
    include SimplifyApi
    attribute :message_text, String, mandatory: true
    attribute :parse_mode, String, values: ["Markdown", "HTML"]
    attribute :disable_web_page_preview, values: [true, false]
  end

  # latitude 	Float 	Latitude of the location in degrees
  # longitude 	Float 	Longitude of the location in degrees
  # live_period 	Integer 	Optional. Period in seconds for which the location can be updated, should be between 60 and 86400.
  class InputLocationMessageContent
    include SimplifyApi
    attribute :latitude, Float, mandatory: true
    attribute :longitude, Float, mandatory: true
    attribute :live_period, Integer
  end

  # latitude 	Float 	Latitude of the venue in degrees
  # longitude 	Float 	Longitude of the venue in degrees
  # title 	String 	Name of the venue
  # address 	String 	Address of the venue
  # foursquare_id 	String 	Optional. Foursquare identifier of the venue, if known
  # foursquare_type 	String 	Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
  class InputVenueMessageContent
    include SimplifyApi
    attribute :latitude, Float, mandatory: true
    attribute :longitude, Float, mandatory: true
    attribute :title, String, mandatory: true
    attribute :address, String, mandatory: true
    attribute :foursquare_id, String
    attribute :foursquare_type, String
  end

  # phone_number 	String 	Contact's phone number
  # first_name 	String 	Contact's first name
  # last_name 	String 	Optional. Contact's last name
  # vcard 	String 	Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes
  class InputContactMessageContent
    include SimplifyApi
    attribute :phone_number, String, mandatory: true
    attribute :first_name, String, mandatory: true
    attribute :last_name, String
    attribute :vcard, String
  end

  # result_id 	String 	The unique identifier for the result that was chosen
  # from 	User 	The user that chose the result
  # location 	Location 	Optional. Sender location, only for bots that require user location
  # inline_message_id 	String 	Optional. Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message. Will be also received in callback queries and can be used to edit the message.
  # query 	String 	The query that was used to obtain the result
  class ChosenInlineResult
    include SimplifyApi
    attribute :result_id, String, mandatory: true
    attribute :from, User, mandatory: true
    attribute :location, Location
    attribute :inline_message_id
    attribute :query, String, mandatory: true
  end
end