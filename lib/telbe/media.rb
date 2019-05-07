module Telbe
  class PhotoSize
    include Virtus.model
    attribute :file_id, String
    attribute :width, Integer
    attribute :height, Integer
    attribute :file_size, Integer
  end

  class Animation
    include Virtus.model
    attribute :file_id, String
    attribute :width, Integer
    attribute :height, Integer
    attribute :duration, Integer
    attribute :thumb, PhotoSize
    attribute :file_name, String
    attribute :mime_type, String
    attribute :file_size, Integer
  end

  class Document
    include Virtus.model
    attribute :file_id, String
    attribute :thumb, PhotoSize
    attribute :file_name, String
    attribute :mime_type, String
    attribute :file_size, Integer
  end

  class Audio
    include Virtus.model
    attribute :file_id, String
    attribute :duration, Integer
    attribute :performer, String
    attribute :title, String
    attribute :mime_type, String
    attribute :file_size, Integer
    attribute :thumb, PhotoSize
  end

  class Video
    include Virtus.model
    attribute :file_id, String
    attribute :width, Integer
    attribute :height, Integer
    attribute :duration, Integer
    attribute :thumb, PhotoSize
    attribute :mime_type, String
    attribute :file_size, Integer
  end

  class Voice
    include Virtus.model
    attribute :file_id, String
    attribute :duration, Integer
    attribute :mime_type, String
    attribute :file_size, Integer
  end

  class VideoNote
    include Virtus.model
    attribute :file_id, String
    attribute :length, Integer
    attribute :duration, Integer
    attribute :thumb, PhotoSize
    attribute :file_size, Integer
  end

  class InputMedia
    include Virtus.model
    attribute :type, String
    attribute :media, String
    attribute :caption, String
    attribute :parse_mode, String
  end
    
  class InputMediaAnimation < InputMedia
    attribute :thumb, Object
    attribute :width, Integer
    attribute :height, Integer
    attribute :duration, Integer
  end

  class InputMediaDocument < InputMedia
    include Virtus.model
    attribute :thumb, Object
  end

  class InputMediaAudio < InputMedia
    include Virtus.model
    attribute :thumb, Object
    attribute :duration, Integer
    attribute :performer, String
    attribute :title, String
  end

  class InputMediaPhoto < InputMedia
  end

  class InputMediaVideo < InputMedia
    attribute :thumb, Object
    attribute :width, Integer
    attribute :height, Integer
    attribute :duration, Integer
    attribute :supports_streaming, Boolean
  end
end
