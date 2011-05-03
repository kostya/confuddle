module Unfuzzle
  
  # = Priority
  #
  # Represents a priority for a ticket.
  #
  class Priority
    
    def initialize(id)
      @id = id
    end
    
    # The name of the priority based on the supplied ID
    def name
      mapping[@id]
    end
    
    private
    def mapping
      {
        5 => 'Highest',
        4 => 'High',
        3 => 'Normal',
        2 => 'Low',
        1 => 'Lowest'
      }
    end
    
  end
end