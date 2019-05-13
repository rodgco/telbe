module Telbe
  class Bot
    def get_url(file)
      "https://api.telegram.org/file/bot#{@token}/#{file.file_path}"
    end

    def get_file(get_file_descriptor)
      File.new(request(:getFile, get_file_descriptor))
    end

    def send_photo(send_photo_descriptor)
      Message.new(request(:sendPhoto, send_photo_descriptor))
    end

    def send_audio(send_audio_descriptor)
      Message.new(request(:sendAudio, send_audio_descriptor))
    end

    def send_document(send_document_descriptor)
      Message.new(request(:sendDocument, send_document_descriptor))
    end

    def send_video(send_video_descriptor)
      Message.new(request(:sendVideo, send_video_descriptor))
    end

    def send_animation(send_animation_descriptor)
      Message.new(request(:sendAnimation, send_animation_descriptor))
    end

    def send_voice(send_voice_descriptor)
      Message.new(request(:sendVoice, send_voice_descriptor))
    end

    def send_video_note(send_video_note_descriptor)
      Message.new(request(:sendVideoNote, send_video_note_descriptor))
    end

    def send_media_group(send_media_group_descriptor)
      request(:sendMediaGroup, send_media_group_descriptor).collect do |m|
        Message.new(m)
      end
    end
  end

  # file_id 	String 	Unique identifier for this file
  # file_size 	Integer 	Optional. File size, if known
  # file_path 	String 	Optional. File path. Use https://api.telegram.org/file/bot<token>/<file_path> to get the file.
  class File
    include SimplifyApi
    attribute :file_id, String, mandatory: true
    attribute :file_size, Integer
    attribute :file_path, String
  end

  # file_id 	String 	Yes 	File identifier to get info about
  class GetFileDescriptor
    include SimplifyApi
    attribute :file_id, String, mandatory: true
  end

  class InputFile
    include SimplifyApi
  end

  # file_id 	String 	Unique identifier for this file
  # width 	Integer 	Photo width
  # height 	Integer 	Photo height
  # file_size 	Integer 	Optional. File size
  class PhotoSize
    include SimplifyApi
    attribute :file_id, String, mandatory: true
    attribute :width, Integer, mandatory: true
    attribute :height, Integer, mandatory: true
    attribute :file_size, Integer
  end

  # file_id 	String 	Unique file identifier
  # width 	Integer 	Video width as defined by sender
  # height 	Integer 	Video height as defined by sender
  # duration 	Integer 	Duration of the video in seconds as defined by sender
  # thumb 	PhotoSize 	Optional. Animation thumbnail as defined by sender
  # file_name 	String 	Optional. Original animation filename as defined by sender
  # mime_type 	String 	Optional. MIME type of the file as defined by sender
  # file_size 	Integer 	Optional. File size
  class Animation
    include SimplifyApi
    attribute :file_id, String, mandatory: true
    attribute :width, Integer, mandatory: true
    attribute :height, Integer, mandatory: true
    attribute :duration, Integer, mandatory: true
    attribute :thumb, PhotoSize
    attribute :file_name, String
    attribute :mime_type, String
    attribute :file_size, Integer
  end

  # file_id 	String 	Unique file identifier
  # thumb 	PhotoSize 	Optional. Document thumbnail as defined by sender
  # file_name 	String 	Optional. Original filename as defined by sender
  # mime_type 	String 	Optional. MIME type of the file as defined by sender
  # file_size 	Integer 	Optional. File size
  class Document
    include SimplifyApi
    attribute :file_id, String, mandatory: true
    attribute :thumb, PhotoSize
    attribute :file_name, String
    attribute :mime_type, String
    attribute :file_size, Integer
  end

  # file_id 	String 	Unique identifier for this file
  # duration 	Integer 	Duration of the audio in seconds as defined by sender
  # performer 	String 	Optional. Performer of the audio as defined by sender or by audio tags
  # title 	String 	Optional. Title of the audio as defined by sender or by audio tags
  # mime_type 	String 	Optional. MIME type of the file as defined by sender
  # file_size 	Integer 	Optional. File size
  # thumb 	PhotoSize 	Optional. Thumbnail of the album cover to which the music file belongs
  class Audio
    include SimplifyApi
    attribute :file_id, String, mandatory: true
    attribute :duration, Integer, mandatory: true
    attribute :performer, String
    attribute :title, String
    attribute :mime_type, String
    attribute :file_size, Integer
    attribute :thumb, PhotoSize
  end

  # file_id 	String 	Unique identifier for this file
  # width 	Integer 	Video width as defined by sender
  # height 	Integer 	Video height as defined by sender
  # duration 	Integer 	Duration of the video in seconds as defined by sender
  # thumb 	PhotoSize 	Optional. Video thumbnail
  # mime_type 	String 	Optional. Mime type of a file as defined by sender
  # file_size 	Integer 	Optional. File size
  class Video
    include SimplifyApi
    attribute :file_id, String, mandatory: true
    attribute :width, Integer, mandatory: true
    attribute :height, Integer, mandatory: true
    attribute :duration, Integer, mandatory: true
    attribute :thumb, PhotoSize
    attribute :mime_type, String
    attribute :file_size, Integer
  end

  # file_id 	String 	Unique identifier for this file
  # duration 	Integer 	Duration of the audio in seconds as defined by sender
  # mime_type 	String 	Optional. MIME type of the file as defined by sender
  # file_size 	Integer 	Optional. File size
  class Voice
    include SimplifyApi
    attribute :file_id, String, mandatory: true
    attribute :duration, Integer, mandatory: true
    attribute :mime_type, String
    attribute :file_size, Integer
  end

  # file_id 	String 	Unique identifier for this file
  # length 	Integer 	Video width and height (diameter of the video message) as defined by sender
  # duration 	Integer 	Duration of the video in seconds as defined by sender
  # thumb 	PhotoSize 	Optional. Video thumbnail
  # file_size 	Integer 	Optional. File size
  class VideoNote
    include SimplifyApi
    attribute :file_id, String, mandatory: true
    attribute :length, Integer, mandatory: true
    attribute :duration, Integer, mandatory: true
    attribute :thumb, PhotoSize
    attribute :file_size, Integer    
  end

  # type 	String 	Type of the result, must be animation
  # media 	String 	File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
  # thumb 	InputFile or String 	Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
  # caption 	String 	Optional. Caption of the animation to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # width 	Integer 	Optional. Animation width
  # height 	Integer 	Optional. Animation height
  # duration 	Integer 	Optional. Animation duration
  class InputMediaAnimation < InputMedia
    attribute :thumb, Object
    attribute :width, Integer
    attribute :height, Integer
    attribute :duration, Integer
  end

  # type 	String 	Type of the result, must be document
  # media 	String 	File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
  # thumb 	InputFile or String 	Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
  # caption 	String 	Optional. Caption of the document to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  class InputMediaDocument < InputMedia
    attribute :thumb, Object
  end

  # type 	String 	Type of the result, must be audio
  # media 	String 	File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
  # thumb 	InputFile or String 	Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
  # caption 	String 	Optional. Caption of the audio to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # duration 	Integer 	Optional. Duration of the audio in seconds
  # performer 	String 	Optional. Performer of the audio
  # title 	String 	Optional. Title of the audio
  class InputMediaAudio < InputMedia
    attribute :thumb, Object
    attribute :duration, Integer
    attribute :performer, String
    attribute :title, String    
  end

  # type 	String 	Type of the result, must be photo
  # media 	String 	File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
  # caption 	String 	Optional. Caption of the photo to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  class InputMediaPhoto < InputMedia
  end

  # type 	String 	Type of the result, must be video
  # media 	String 	File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
  # thumb 	InputFile or String 	Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
  # caption 	String 	Optional. Caption of the video to be sent, 0-1024 characters
  # parse_mode 	String 	Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # width 	Integer 	Optional. Video width
  # height 	Integer 	Optional. Video height
  # duration 	Integer 	Optional. Video duration
  # supports_streaming 	Boolean 	Optional. Pass True, if the uploaded video is suitable for streaming
  class InputMediaVideo < InputMedia
    attribute :thumb, Object
    attribute :width, Integer
    attribute :height, Integer
    attribute :duration, Integer
    attribute :supports_streaming, values: [true, false]
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # photo 	InputFile or String 	Yes 	Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. More info on Sending Files »
  # caption 	String 	Optional 	Photo caption (may also be used when resending photos by file_id), 0-1024 characters
  # parse_mode 	String 	Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class SendPhotoDescriptor < MediaDescriptor
    attribute :photo, Object, mandatory: true
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # audio 	InputFile or String 	Yes 	Audio file to send. Pass a file_id as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
  # caption 	String 	Optional 	Audio caption, 0-1024 characters
  # parse_mode 	String 	Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # duration 	Integer 	Optional 	Duration of the audio in seconds
  # performer 	String 	Optional 	Performer
  # title 	String 	Optional 	Track name
  # thumb 	InputFile or String 	Optional 	Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class SendAudioDescriptor < MediaDescriptor
    attribute :audio, Object, mandatory: true
    attribute :duration, Integer
    attribute :performer, String
    attribute :title, String
    attribute :thumb, Object
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # document 	InputFile or String 	Yes 	File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
  # thumb 	InputFile or String 	Optional 	Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
  # caption 	String 	Optional 	Document caption (may also be used when resending documents by file_id), 0-1024 characters
  # parse_mode 	String 	Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class SendDocumentDescriptor < MediaDescriptor
    attribute :document, Object, mandatory: true
    attribute :thumb, Object
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # video 	InputFile or String 	Yes 	Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data. More info on Sending Files »
  # duration 	Integer 	Optional 	Duration of sent video in seconds
  # width 	Integer 	Optional 	Video width
  # height 	Integer 	Optional 	Video height
  # thumb 	InputFile or String 	Optional 	Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
  # caption 	String 	Optional 	Video caption (may also be used when resending videos by file_id), 0-1024 characters
  # parse_mode 	String 	Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # supports_streaming 	Boolean 	Optional 	Pass True, if the uploaded video is suitable for streaming
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Opt
  class SendVideoDescriptor < MediaDescriptor
    attribute :video, Object, mandatory: true
    attribute :duration, Integer
    attribute :width, Integer
    attribute :height, Integer
    attribute :thumb, Object
    attribute :supports_streaming, values: [true, false]
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # animation 	InputFile or String 	Yes 	Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data. More info on Sending Files »
  # duration 	Integer 	Optional 	Duration of sent animation in seconds
  # width 	Integer 	Optional 	Animation width
  # height 	Integer 	Optional 	Animation height
  # thumb 	InputFile or String 	Optional 	Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
  # caption 	String 	Optional 	Animation caption (may also be used when resending animation by file_id), 0-1024 characters
  # parse_mode 	String 	Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class SendAnimationDescriptor < MediaDescriptor
    attribute :animation, Object, mandatory: true
    attribute :duration, Integer
    attribute :width, Integer
    attribute :height, Integer
    attribute :thumb, Object
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # voice 	InputFile or String 	Yes 	Audio file to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
  # caption 	String 	Optional 	Voice message caption, 0-1024 characters
  # parse_mode 	String 	Optional 	Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
  # duration 	Integer 	Optional 	Duration of the voice message in seconds
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class SendVoiceDescriptor < MediaDescriptor
    attribute :voice, Object, mandatory: true
    attribute :duration, Integer
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # video_note 	InputFile or String 	Yes 	Video note to send. Pass a file_id as String to send a video note that exists on the Telegram servers (recommended) or upload a new video using multipart/form-data. More info on Sending Files ». Sending video notes by a URL is currently unsupported
  # duration 	Integer 	Optional 	Duration of sent video in seconds
  # length 	Integer 	Optional 	Video width and height, i.e. diameter of the video message
  # thumb 	InputFile or String 	Optional 	Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class SendVideoNoteDescriptor < Descriptor
    attribute :video_note, InputFile or String
    attribute :duration, Integer
    attribute :length, Integer
    attribute :thumb, InputFile or String
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # media 	Array of InputMediaPhoto and InputMediaVideo 	Yes 	A JSON-serialized array describing photos and videos to be sent, must include 2–10 items
  # disable_notification 	Boolean 	Optional 	Sends the messages silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the messages are a reply, ID of the original message
  class SendMediaGroupDescriptor
    include SimplifyApi
    attribute :chat_id, Integer or String
    attribute :media, [Object]
    attribute :disable_notification, values: [true, false]
    attribute :reply_to_message_id, Integer
  end
end
