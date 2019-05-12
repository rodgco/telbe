module Telbe
  class Bot
    def send_contact(contact_descriptor)
      Message.new(request(:sendContact, contact_descriptor))
    end
  end

  class Contact
    include SimplifyApi
  end

  class ContactDescriptor
    include SimplifyApi
  end
end
