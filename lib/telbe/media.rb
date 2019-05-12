module Telbe
  class PhotoSize
    include SimplifyApi
  end

  class Animation
    include SimplifyApi
  end

  class Document
    include SimplifyApi
  end

  class Audio
    include SimplifyApi
  end

  class Video
    include SimplifyApi
  end

  class Voice
    include SimplifyApi
  end

  class VideoNote
    include SimplifyApi
  end

  class InputMedia
    include SimplifyApi
  end
    
  class InputMediaAnimation < InputMedia
  end

  class InputMediaDocument < InputMedia
  end

  class InputMediaAudio < InputMedia
  end

  class InputMediaPhoto < InputMedia
  end

  class InputMediaVideo < InputMedia
  end
end
