module Telbe
  class Location
    include Virtus.model
    attribute :longitude, Float
    attribute :latitude, Float
  end

  class Venue
    include Virtus.model
    attribute :location, Location
    attribute :address, String
    attribute :title, String
    attribute :foursquare_id, String
    attribute :foursquare_type, String
  end
end
