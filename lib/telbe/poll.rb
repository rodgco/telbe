module Telbe
  class Bot
  end

  class PollOption
    include Virtus.model
    attribute :text, String
    attribute :voter_count, Integer
  end

  class Poll
    include Virtus.model
    attribute :id, String
    attribute :question, String
    attribute :options, Array # of PollOption
    attribute :is_closed, Boolean
  end
end
