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
    include InitializeFromHash
  end

  class ChatMember
    include InitializeFromHash
  end
end
