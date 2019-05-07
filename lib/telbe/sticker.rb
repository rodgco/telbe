module Telbe
  class Bot
  end

  class MaskPosition
    include Virtus.model
    attribute :point, String
    attribute :x_shift, Float
    attribute :y_shift, Float
    attribute :scale, Float
  end

  class Sticker
    include Virtus.model
    attribute :file_id, String
    attribute :width, Integer
    attribute :height, Integer
    attribute :thumb, PhotoSize
    attribute :emoji, String
    attribute :set_name, String
    attribute :mask_position, MaskPosition
    attribute :file_size, Integer
  end

  class StickerSet
    include Virtus.model
    attribute :name, String
    attribute :title, String
    attribute :contains_masks, Boolean
    attribute :stickers, Array # of Sticker
  end
end
