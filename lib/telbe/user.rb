module Telbe
  CHAT_MEMBER_STATUS = ["creator", "administrator", "member", "restricted", "left", "kicked"]

  class Bot
    def get_chat_administrators(chatid_descriptor)
      request(:getChatAdministrators, chatid_descriptor).collect do |member_hash|
        ChatMember.new(member_hash)
      end
    end

    def get_chat_members_count(chatid_descriptor)
      request(:getChatMembersCount, chatid_descriptor)
    end

    def get_me
      User.new(request(:getMe))
    end
  end

  class ChatIdDescriptor
    include SimplifyApi
    attribute :chat_id, Integer, mandatory: true
  end

  # id 	Integer 	Unique identifier for this user or bot
  # is_bot 	Boolean 	True, if this user is a bot
  # first_name 	String 	User‘s or bot’s first name
  # last_name 	String 	Optional. User‘s or bot’s last name
  # username 	String 	Optional. User‘s or bot’s username
  # language_code 	String 	Optional. IETF language tag of the user's language
  class User
    include SimplifyApi
    attribute :id, Integer, mandatory: true
    attribute :is_bot, values: [true, false], mandatory: true
    attribute :first_name, String, mandatory: true
    attribute :last_name, String
    attribute :username, String
    attribute :language_code, String
  end

  # Created to nest the arrays in UserProfilePhotos
  class UserProfilePhoto
    include SimplifyApi
    attribute :photo, [PhotoSize]
  end

  # total_count 	Integer 	Total number of profile pictures the target user has
  # photos 	Array of Array of PhotoSize 	Requested profile pictures (in up to 4 sizes each)
  class UserProfilePhotos
    include SimplifyApi
    attribute :total_count, Integer
    attribute :photos, [UserProfilePhoto]
  end

  # user 	User 	Information about the user
  # status 	String 	The member's status in the chat. Can be "creator", "administrator", "member", "restricted", "left" or "kicked"
  # until_date 	Integer 	Optional. Restricted and kicked only. Date when restrictions will be lifted for this user, unix time
  # can_be_edited 	Boolean 	Optional. Administrators only. True, if the bot is allowed to edit administrator privileges of that user
  # can_change_info 	Boolean 	Optional. Administrators only. True, if the administrator can change the chat title, photo and other settings
  # can_post_messages 	Boolean 	Optional. Administrators only. True, if the administrator can post in the channel, channels only
  # can_edit_messages 	Boolean 	Optional. Administrators only. True, if the administrator can edit messages of other users and can pin messages, channels only
  # can_delete_messages 	Boolean 	Optional. Administrators only. True, if the administrator can delete messages of other users
  # can_invite_users 	Boolean 	Optional. Administrators only. True, if the administrator can invite new users to the chat
  # can_restrict_members 	Boolean 	Optional. Administrators only. True, if the administrator can restrict, ban or unban chat members
  # can_pin_messages 	Boolean 	Optional. Administrators only. True, if the administrator can pin messages, groups and supergroups only
  # can_promote_members 	Boolean 	Optional. Administrators only. True, if the administrator can add new administrators with a subset of his own privileges or demote administrators that he has promoted, directly or indirectly (promoted by administrators that were appointed by the user)
  # is_member 	Boolean 	Optional. Restricted only. True, if the user is a member of the chat at the moment of the request
  # can_send_messages 	Boolean 	Optional. Restricted only. True, if the user can send text messages, contacts, locations and venues
  # can_send_media_messages 	Boolean 	Optional. Restricted only. True, if the user can send audios, documents, photos, videos, video notes and voice notes, implies can_send_messages
  # can_send_other_messages 	Boolean 	Optional. Restricted only. True, if the user can send animations, games, stickers and use inline bots, implies can_send_media_messages
  # can_add_web_page_previews 	Boolean 	Optional. Restricted only. True, if user may add web page previews to his messages, implies can_send_media_messages
  class ChatMember
    include SimplifyApi
    attribute :user, User, mandatory: true
    attribute :status, CHAT_MEMBER_STATUS, mandatory: true
    attribute :until_date, Integer
    attribute :can_be_edited, values: [true, false]
    attribute :can_change_info, values: [true, false]
    attribute :can_post_messages, values: [true, false]
    attribute :can_edit_messages, values: [true, false]
    attribute :can_delete_messages, values: [true, false]
    attribute :can_invite_users, values: [true, false]
    attribute :can_restrict_members, values: [true, false]
    attribute :can_pin_messages, values: [true, false]
    attribute :can_promote_members, values: [true, false]
    attribute :is_member, values: [true, false]
    attribute :can_send_messages, values: [true, false]
    attribute :can_send_media_messages, values: [true, false]
    attribute :can_send_other_messages, values: [true, false]
    attribute :can_add_web_page_previews, values: [true, false]
  end
end
