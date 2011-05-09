module Unfuzzle

  class TimeEntryGroup
    include Graft
    attribute :title
  end

  class TimeEntry

    include Graft
    
    attribute :date
    attribute :description
    attribute :hours
    attribute :person_id, :from => "person-id", :type => :integer
    attribute :ticket_id, :from => "ticket-id", :time => :integer

    attr_accessor :title # title of ticket

    # Hash representation of this time entry's data (for updating)
    def to_hash
      {
        'date'           => date,
        'description'    => description,
        'hours'          => hours,
        'person-id'      => person_id,
        "ticket-id"      => ticket_id
      }
    end


    # times for project
    def self.time_invested(project_id, start_date, end_date)
      response = Request.get("/projects/#{project_id}/time_invested", query(start_date, end_date))
      parse_group_collection(response.body)
    end

    # times for account
    def self.all_time_invested(start_date, end_date)
      response = Request.get("/account/time_invested", query(start_date, end_date))
      parse_group_collection(response.body)
    end

    def self.all_for_ticket(ticket, start_date = nil, end_date = nil)
      response = Request.get("/projects/#{ticket.project_id}/tickets/#{ticket.id}/time_entries", query(start_date, end_date))
      collection_from(response.body, 'time-entries/time-entry')
    end

    # Create a ticket in unfuddle
    def create(project_id, ticket_id)
      resource_path = "/projects/#{project_id}/tickets/#{ticket_id}/time_entries"
      Request.post(resource_path, self.to_xml('time-entry'))
    end

  protected

    def self.query(start_date, end_date)
      # [person, ticket, priority, component, version, severity, milestone, due_on, reporter, assignee, status, resolution]
      group = "ticket"
      query = "?group_by=#{group}"
      query += "&start_date=#{start_date.strftime("%Y/%m/%d")}" if start_date
      query += "&end_date=#{end_date.strftime("%Y/%m/%d")}" if end_date
      query
    end

    def self.parse_group_collection(body)
      res = collection_from_block(body, "groups/group") do |str|
        group = TimeEntryGroup.new(str)
        times = collection_from(str, 'time-entries/time-entry').map{|time| time.title = group.title; time}
      end
      res.flatten
    end
    
  end
end