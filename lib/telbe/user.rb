module Telbe
  class Bot
    def get_chat_administrators(chatid_descriptor)
      request(:getChatAdministrators, chatid_descriptor).collect do |member_hash|
        ChatMember.new(member_hash)
      end
    end

    def get_chat_members_count(chatid_descriptor)
      request(:getChatMembersCount, chatid_descriptor)
    end
  end
  
  class User
    include Virtus.model
    attribute :id, Integer #Unique identifier for this user or bot
    alias_method :to_i, :id
    attribute :is_bot, Boolean
    attribute :first_name, String #User‘s or bot’s first name
    attribute :last_name, String
    attribute :username, String
    attribute :language_code, String
  end

  class ChatMember
    include Virtus.model
    attribute :user, User
    attribute :status, String
    attribute :until_date, Integer
    attribute :can_be_edited, Boolean
    attribute :can_change_info, Boolean
    attribute :can_post_messages, Boolean
    attribute :can_edit_messages, Boolean
    attribute :can_delete_messages, Boolean
    attribute :can_invite_users, Boolean
    attribute :can_restrict_members, Boolean
    attribute :can_pin_messages, Boolean
    attribute :can_promote_members, Boolean
    attribute :is_member, Boolean
    attribute :can_send_messages, Boolean
    attribute :can_send_media_messages, Boolean
    attribute :can_send_other_messages, Boolean
    attribute :can_add_web_page_previews, Boolean
  end
end
