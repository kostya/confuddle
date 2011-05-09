module Unfuzzle

  #
  class Group

    include Graft

    attribute :title


    def time_entries
      collection_from(source_data, 'time-entries/time-entry')
    end
  end
end
