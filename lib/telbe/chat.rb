module Telbe
  class Bot
    def get_chat(get_chat_descriptor)
      Chat.new(request(:getChat, get_chat_descriptor))
    end

    def get_chat_administrators(get_chat_descriptor)
      request(:getChatAdministrators, get_chat_descriptor).collect! do |chat_administrator|
        ChatMember.new(chat_administrator)
      end
    end

    def get_chat_members_count(get_chat_descriptor)
      request(:getChatMembersCount, get_chat_descriptor)
    end

    def get_chat_member(chat_member_descriptor)
      ChatMember.new(request(:getChatMember, chat_member_descriptor))
    end

    def send_chat_action(send_chat_action_descriptor)
      request(:sendChatAction, send_chat_action_descriptor)
    end

    def kick_chat_member(kick_chat_member_descriptor)
      request(:kickChatMember, kick_chat_member_descriptor)
    end

    def unban_chat_member(chat_member_descriptor)
      request(:unbanChatMember, chat_member_descriptor)
    end

    def restrict_chat_member(restrict_chat_member_descriptor)
      request(:restrictChatMember, restrict_chat_member_descriptor)
    end

    def promote_chat_member(promote_chat_member_descriptor)
      request(:promoteChatMember, promote_chat_member_descriptor)
    end

    def export_chat_invite_link(get_chat_descriptor)
      request(:exportChatInviteLink, get_chat_descriptor)
    end

    def set_chat_photo(set_chat_photo_descriptor)
      request(:setChatPhoto, set_chat_photo_descriptor)
    end

    def delete_chat_photo(get_chat_descriptor)
      request(:deleteChatPhoto, get_chat_descriptor)
    end

    def set_chat_title(set_chat_title_descriptor)
      request(:setChatTitle, set_chat_title_descriptor)
    end

    def set_chat_description(set_chat_description_descriptor)
      request(:setChatDescription, set_chat_description_descriptor)
    end

    def pin_chat_message(pin_chat_message_descriptor)
      request(:pinChatMessage, pin_chat_message_descriptor)
    end

    def unpin_chat_message(get_chat_descriptor)
      request(:unpinChatMessage, get_chat_descriptor)
    end

    def leave_chat(get_chat_descriptor)
      request(:leaveChat, get_chat_descriptor)
    end

    def set_chat_sticker_set(set_chat_sticker_set_descriptor)
      request(:setChatStickerSet, set_chat_sticker_set_descriptor)
    end

    def delete_chat_sticker_set(get_chat_descriptor)
      request(:deleteChatStickerSet, get_chat_descriptor)
    end
  end

  # small_file_id 	String 	Unique file identifier of small (160x160) chat photo. This file_id can be used only for photo download.
  # big_file_id 	String 	Unique file identifier of big (640x640) chat photo. This file_id can be used only for photo download.
  class ChatPhoto
    include SimplifyApi
    attribute :small_file_id, String, mandatory: true
    attribute :big_file_id, String, mandatory: true
  end

  class Message # Dummy
  end

  # id 	Integer 	Unique identifier for this chat. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
  # type 	String 	Type of chat, can be either “private”, “group”, “supergroup” or “channel”
  # title 	String 	Optional. Title, for supergroups, channels and group chats
  # username 	String 	Optional. Username, for private chats, supergroups and channels if available
  # first_name 	String 	Optional. First name of the other party in a private chat
  # last_name 	String 	Optional. Last name of the other party in a private chat
  # all_members_are_administrators 	Boolean 	Optional. True if a group has ‘All Members Are Admins’ enabled.
  # photo 	ChatPhoto 	Optional. Chat photo. Returned only in getChat.
  # description 	String 	Optional. Description, for supergroups and channel chats. Returned only in getChat.
  # invite_link 	String 	Optional. Chat invite link, for supergroups and channel chats. Each administrator in a chat generates their own invite links, so the bot must first generate the link using exportChatInviteLink. Returned only in getChat.
  # pinned_message 	Message 	Optional. Pinned message, for groups, supergroups and channels. Returned only in getChat.
  # sticker_set_name 	String 	Optional. For supergroups, name of group sticker set. Returned only in getChat.
  # can_set_sticker_set 	Boolean 	Optional. True, if the bot can change the group sticker set. Returned only in getChat.
  class Chat
    include SimplifyApi
    attribute :id, Integer, mandatory: true
    attribute :type, String, mandatory: true, values: %w[private group supergroup channel]
    attribute :title, String
    attribute :username, String
    attribute :first_name, String
    attribute :last_name, String
    attribute :all_members_are_administrators, values: [true, false]
    attribute :photo, ChatPhoto
    attribute :description, String
    attribute :invite_link, String
    attribute :pinned_message, Message
    attribute :sticker_set_name, String
    attribute :can_set_sticker_set, values: [true, false]
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # action 	String 	Yes 	Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location data, record_video_note or upload_video_note for video notes.
  class SendChatActionDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :action, String, values: ["typing", "upload_photo", "record_video", "upload_video", "record_audio", "upload_audio", "upload_document", "find_location", "record_video_note", "upload_video_note"]
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  class GetChatDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target group or username of the target supergroup or channel (in the format @channelusername)
  # user_id 	Integer 	Yes 	Unique identifier of the target user
  # until_date 	Integer 	Optional 	Date when the user will be unbanned, unix time. If user is banned for more than 366 days or less than 30 seconds from the current time they are considered to be banned forever
  class KickChatMemberDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :user_id, Integer, mandatory: true
    attribute :until_date, Integer
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target group or username of the target supergroup or channel (in the format @channelusername)
  # user_id 	Integer 	Yes 	Unique identifier of the target user
  class ChatMemberDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :user_id, Integer, mandatory: true
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
  # user_id 	Integer 	Yes 	Unique identifier of the target user
  # until_date 	Integer 	Optional 	Date when restrictions will be lifted for the user, unix time. If user is restricted for more than 366 days or less than 30 seconds from the current time, they are considered to be restricted forever
  # can_send_messages 	Boolean 	Optional 	Pass True, if the user can send text messages, contacts, locations and venues
  # can_send_media_messages 	Boolean 	Optional 	Pass True, if the user can send audios, documents, photos, videos, video notes and voice notes, implies can_send_messages
  # can_send_other_messages 	Boolean 	Optional 	Pass True, if the user can send animations, games, stickers and use inline bots, implies can_send_media_messages
  # can_add_web_page_previews 	Boolean 	Optional 	Pass True, if the user may add web page previews to their messages, implies can_send_media_messages
  class RestrictChatMemberDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :user_id, Integer, mandatory: true
    attribute :until_date, Integer
    attribute :can_send_messages, values: [true, false]
    attribute :can_send_media_messages, values: [true, false]
    attribute :can_send_other_messages, values: [true, false]
    attribute :can_add_web_page_previews, values: [true, false]
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # user_id 	Integer 	Yes 	Unique identifier of the target user
  # can_change_info 	Boolean 	Optional 	Pass True, if the administrator can change chat title, photo and other settings
  # can_post_messages 	Boolean 	Optional 	Pass True, if the administrator can create channel posts, channels only
  # can_edit_messages 	Boolean 	Optional 	Pass True, if the administrator can edit messages of other users and can pin messages, channels only
  # can_delete_messages 	Boolean 	Optional 	Pass True, if the administrator can delete messages of other users
  # can_invite_users 	Boolean 	Optional 	Pass True, if the administrator can invite new users to the chat
  # can_restrict_members 	Boolean 	Optional 	Pass True, if the administrator can restrict, ban or unban chat members
  # can_pin_messages 	Boolean 	Optional 	Pass True, if the administrator can pin messages, supergroups only
  # can_promote_members 	Boolean 	Optional 	Pass True, if the administrator can add new administrators with a subset of his own privileges or demote administrators that he has promoted, directly or indirectly (promoted by administrators that were appointed by him)
  class PromoteChatMemberDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :user_id, Integer, mandatory: true
    attribute :can_change_info, values: [true, false]
    attribute :can_post_messages, values: [true, false]
    attribute :can_edit_messages, values: [true, false]
    attribute :can_delete_messages, values: [true, false]
    attribute :can_invite_users, values: [true, false]
    attribute :can_restrict_members, values: [true, false]
    attribute :can_pin_messages, values: [true, false]
    attribute :can_promote_members, values: [true, false]    
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # photo 	InputFile 	Yes 	New chat photo, uploaded using multipart/form-data
  class SetChatPhotoDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :photo, InputFile, mandatory: true
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # title 	String 	Yes 	New chat title, 1-255 characters
  class SetChatTitleDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :title, String, mandatory: true
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # description 	String 	Optional 	New chat description, 0-255 characters
  class SetChatDescriptionDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :description, String, mandatory: true
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target channel (in the format @channelusername)
  # message_id 	Integer 	Yes 	Identifier of a message to pin
  # disable_notification 	Boolean 	Optional 	Pass True, if it is not necessary to send a notification to all chat members about the new pinned message. Notifications are always disabled in channels.
  class PinChatMessageDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :message_id, Integer, mandatory: true
    attribute :disable_notification, values: [true, false]
  end

  # chat_id 	Integer or String 	Yes 	Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
  # sticker_set_name 	String 	Yes 	Name of the sticker set to be set as the group sticker set
  class SetChatStickerSetDescriptor
    include SimplifyApi
    attribute :chat_id, Object, mandatory: true
    attribute :sticker_set_name, String, mandatory: true
  end
end
