module Telbe
  class Bot
    def send_contact(contact_descriptor)
      Message.new(request(:sendContact, contact_descriptor))
    end
  end

  class Contact
    include InitializeFromHash
  end

  class ContactDescriptor
    include InitializeFromHash
  end
end
