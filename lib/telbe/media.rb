module Telbe
  class PhotoSize
    include InitializeFromHash
  end

  class Animation
    include InitializeFromHash
  end

  class Document
    include InitializeFromHash
  end

  class Audio
    include InitializeFromHash
  end

  class Video
    include InitializeFromHash
  end

  class Voice
    include InitializeFromHash
  end

  class VideoNote
    include InitializeFromHash
  end

  class InputMedia
    include InitializeFromHash
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
