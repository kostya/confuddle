module Unfuzzle

  #
  class TimeEntry

    include Graft

    attribute :date
    attribute :description
    attribute :hours
    attribute :person_id, :from => "person-id", :type => :integer
    attribute :ticket_id, :from => "ticket-id", :time => :integer

    # Return a list of all tickets for an individual project
    def self.time_invested(project_id, start_date, end_date)
      # [person, ticket, priority, component, version, severity, milestone, due_on, reporter, assignee, status, resolution]
      group = "ticket"
      query = "?group_by=#{group}&start_date=#{start_date.strftime("%Y/%m/%d")}&end_date=#{end_date.strftime("%Y/%m/%d")}"
      response = Request.get("/projects/#{project_id}/time_invested", query)
      collection_from(response.body, 'time-entries/time-entry')
    end
    
  end
end
  
  