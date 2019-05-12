module Telbe
  class Bot
    def send_sticker(send_sticker_descriptor)
      Message.new(request(:sendSticker, send_sticker_descriptor))
    end

    def get_sticker_set(get_sticker_set_descriptor)
      StickerSet.new(request(:getStickerSet, get_sticker_set_descriptor))
    end

    def upload_sticker_file(upload_sticker_file_descriptor)
      File.new(request(:uploadStickerFile, upload_sticker_file_descriptor))
    end

    def create_new_sticker_set(create_new_sticker_set_descriptor)
      request(:createNewStickerSet, create_new_sticker_set_descriptor)
    end

    def add_sticker_to_set(add_sticker_to_set_descriptor)
      request(:addStickerToSet, add_sticker_to_set_descriptor)
    end

    def set_sticker_position_in_set(set_sticker_position_in_set_descriptor)
      request(:setStickerPositionInSet, set_sticker_position_in_set_descriptor)
    end

    def delete_sticker_from_set(delete_sticker_from_set_descriptor)
      request(:deleteStickerFromSet, delete_sticker_from_set_descriptor)
    end
  end

  # point 	String 	The part of the face relative to which the mask should be placed. One of “forehead”, “eyes”, “mouth”, or “chin”.
  # x_shift 	Float number 	Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. For example, choosing -1.0 will place mask just to the left of the default mask position.
  # y_shift 	Float number 	Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. For example, 1.0 will place the mask just below the default mask position.
  # scale 	Float number 	Mask scaling coefficient. For example, 2.0 means double size.
  class MaskPosition
    include SimplifyApi
    attribute :point, String, mandatory: true, values: ["forehead", "eyes", "mouth", "chin"]
    attribute :x_shift, Float, mandatory: true
    attribute :y_shift, Float, mandatory: true
    attribute :scale, Float, mandatory: true
  end

  # file_id 	String 	Unique identifier for this file
  # width 	Integer 	Sticker width
  # height 	Integer 	Sticker height
  # thumb 	PhotoSize 	Optional. Sticker thumbnail in the .webp or .jpg format
  # emoji 	String 	Optional. Emoji associated with the sticker
  # set_name 	String 	Optional. Name of the sticker set to which the sticker belongs
  # mask_position 	MaskPosition 	Optional. For mask stickers, the position where the mask should be placed
  # file_size 	Integer 	Optional. File size
  class Sticker
    include SimplifyApi
    attribute :file_id, String, mandatory: true
    attribute :width, Integer, mandatory: true
    attribute :height, Integer, mandatory: true
    attribute :thumb, PhotoSize
    attribute :emoji, String
    attribute :set_name, String
    attribute :mask_position, MaskPosition
    attribute :file_size, Integer
  end

  # name 	String 	Sticker set name
  # title 	String 	Sticker set title
  # contains_masks 	Boolean 	True, if the sticker set contains masks
  # stickers 	Array of Sticker 	List of all set stickers
  class StickerSet
    include SimplifyApi
    attribute :name, String, mandatory: true
    attribute :title, String, mandatory: true
    attribute :contains_masks, values: [true, false]
    attribute :stickers, [Sticker]
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # sticker 	InputFile or String 	Yes 	Sticker to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a .webp file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
  # disable_notification 	Boolean 	Optional 	Sends the message silently. Users will receive a notification with no sound.
  # reply_to_message_id 	Integer 	Optional 	If the message is a reply, ID of the original message
  # reply_markup 	InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply 	Optional 	Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
  class SendStickerDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :sticker, Object, mandatory: true
    attribute :disable_notification, values: [true, false]
    attribute :reply_to_message_id, Integer
    attribute :reply_markup, Object
  end

  # name 	String 	Yes 	Name of the sticker set
  class GetStickerSetDescriptor
    include SimplifyApi
    attribute :name, Sticker, mandatory: true
  end

  # user_id 	Integer 	Yes 	User identifier of sticker file owner
  # png_sticker 	InputFile 	Yes 	Png image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px.
  class UploadStickerFileDescriptor
    include SimplifyApi
    attribute :user_id, Integer, mandatory: true
    attribute :png_sticker, InputFile, mandatory: true
  end

  # user_id 	Integer 	Yes 	User identifier of created sticker set owner
  # name 	String 	Yes 	Short name of sticker set, to be used in t.me/addstickers/ URLs (e.g., animals). Can contain only english letters, digits and underscores. Must begin with a letter, can't contain consecutive underscores and must end in “_by_<bot username>”. <bot_username> is case insensitive. 1-64 characters.
  # title 	String 	Yes 	Sticker set title, 1-64 characters
  # png_sticker 	InputFile or String 	Yes 	Png image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
  # emojis 	String 	Yes 	One or more emoji corresponding to the sticker
  # contains_masks 	Boolean 	Optional 	Pass True, if a set of mask stickers should be created
  # mask_position 	MaskPosition 	Optional 	A JSON-serialized object for position where the mask should be placed on faces
  class CreateNewStickerSetDescriptor
    include SimplifyApi
    attribute :user_id, Integer, mandatory: true
    attribute :name, String, mandatory: true
    attribute :title, String, mandatory: true
    attribute :png_sticker, Object
    attribute :emojis, String, mandatory: true
    attribute :contains_masks, values: [true, false]
    attribute :mask_position, MaskPosition    
  end

  # user_id 	Integer 	Yes 	User identifier of sticker set owner
  # name 	String 	Yes 	Sticker set name
  # png_sticker 	InputFile or String 	Yes 	Png image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
  # emojis 	String 	Yes 	One or more emoji corresponding to the sticker
  # mask_position 	MaskPosition 	Optional 	A JSON-serialized object for position where the mask should be placed on faces
  class AddStickerToSetDescriptor
    include SimplifyApi
    attribute :user_id, Integer, mandatory: true
    attribute :name, String, mandatory: true
    attribute :png_sticker, Object, mandatory: true
    attribute :emojis, String, mandatory: true
    attribute :mask_position, MaskPosition    
  end

  # sticker 	String 	Yes 	File identifier of the sticker
  # position 	Integer 	Yes 	New sticker position in the set, zero-based
  class SetStickerPositionInSetDescriptor
    include SimplifyApi
    attribute :sticker, String, mandatory: true
    attribute :position, Integer, mandatory: true
  end

  # sticker 	String 	Yes 	File identifier of the sticker
  class DeleteStickerFromSetDescriptor
    include SimplifyApi
    attribute :sticker, String, mandatory: true
  end
end
