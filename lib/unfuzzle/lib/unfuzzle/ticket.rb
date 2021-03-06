module Unfuzzle

  # = Ticket
  #
  # Represents a single Unfuddle Ticket - is associated to a project
  # and optionally a project's milestone.  Has the following attributes:
  #
  # [id] The unique identifier for this ticket
  # [number] The ticket's number - this is displayed in the web interface
  # [title] The title of the ticket (short)
  # [description] The full description of the ticket
  # [status] The ticket's status (new / accepted / resolved / closed)
  # [due_on] The due date for this ticket
  # [created_at] The date/time that this ticket was created
  # [updated_at] The date/time that this ticket was last updated
  #
  class Ticket

    include Graft

    attribute :id, :type => :integer
    attribute :project_id, :from => 'project-id', :type => :integer
    attribute :milestone_id, :from => 'milestone-id', :type => :integer
    attribute :component_id, :from => 'component-id', :type => :integer
    attribute :priority, :type => :integer
    attribute :number, :type => :integer
    attribute :title, :from => 'summary'
    attribute :description
    attribute :due_on, :from => 'due-on', :type => :date
    attribute :created_at, :from => 'created-at', :type => :time
    attribute :updated_at, :from => 'updated-at', :type => :time
    attribute :severity_id, :from => 'severity-id', :type => :integer
    attribute :assignee_id, :from => 'assignee-id', :type => :integer
    attribute :reporter_id, :from => 'reporter-id', :type => :integer
    attribute :status
    attribute :hours, :from => 'hours-estimate-current'
    
    
    def initialize(*args)
      self.priority = 3
      self.status = "new"
      super(*args)
    end

    # Return a list of all tickets for an individual project
    def self.find_all_by_project_id(project_id)
      response = Request.get("/projects/#{project_id}/tickets")
      collection_from(response.body, 'tickets/ticket')
    end

    # Return a list of all tickets for a given milestone as part of a project
    def self.find_all_by_project_id_and_milestone_id(project_id, milestone_id)
      response = Request.get("/projects/#{project_id}/milestones/#{milestone_id}/tickets")
      collection_from(response.body, 'tickets/ticket')
    end
    
    # Return a list of all tickets for a given milestone as part of a project
    def self.find_first_by_project_id_and_number(project_id, number)
      response = Request.get("/projects/#{project_id}/tickets/by_number/#{number}")
      new(response.body)
    end
    
    # Return a list of all tickets for a given milestone as part of a project
    def self.find_first_by_project_id_and_number_with_comments(project_id, number)
      response = Request.get("/projects/#{project_id}/tickets/by_number/#{number}", "?comments=true")
      [new(response.body), Comment.collection_from(response.body, 'comments/comment')]
    end

    
    def self.find_all_by_project_and_report(project_id, report_id)
      response = Request.get("/projects/#{project_id}/ticket_reports/#{report_id}/generate")
      collection_from(response.body, 'tickets/ticket')
    end


    def self.all_by_dinamic_report(with_project_ids = nil, only_my_tickets = false)
      query = "?title=Dynamic&conditions_string=status-neq-closed"
      query += ",assignee-eq-current" if only_my_tickets
      query += "&fields_string=id,number,title,hours,assignee,status,reporter"

      res = []

      if with_project_ids.blank?
        response = Request.get("/ticket_reports/dynamic", query)
        res = collection_from(response.body, 'tickets/ticket')
      else
        with_project_ids.each do |id|
          response = Request.get("/projects/#{id}/ticket_reports/dynamic", query)
          res << collection_from(response.body, 'tickets/ticket')
        end
      end
      
      res.flatten
    end

   
    # The Milestone associated with this ticket
    def milestone
      Milestone.find_by_project_id_and_milestone_id(project_id, milestone_id)
    end
    
    # The Severity associated with this ticket
    def severity
      Severity.find_by_project_id_and_severity_id(project_id, severity_id) unless severity_id.nil?
    end
    
    def severity_name
      severity.name unless severity.nil?
    end
    
    def priority_name
      # priority.name
      Priority.new(priority).name
    end
    
    # The Component associated with this ticket
    def component
      Component.find_by_project_id_and_component_id(project_id, component_id) unless component_id.nil?
    end
    
    def component_name
      component.name unless component.nil?
    end
    
    # Hash representation of this ticket's data (for updating)
    def to_hash
      {
        'id'           => id,
        'project-id'   => project_id,
        'milestone-id' => milestone_id,
        'priority'     => priority,
        'severity-id'  => severity_id,
        'number'       => number,
        'summary'      => title,
        'description'  => description,
        'status'       => status,
        'assignee-id'  => assignee_id,
        'reporter-id'  => reporter_id#,
        #'hours'        => hours
      }
    end
    
    # Update the ticket's data in unfuddle
    def update
      resource_path = "/projects/#{project_id}/tickets/#{id}"
      Request.put(resource_path, self.to_xml('ticket'))
    end
    
    # Create a ticket in unfuddle
    def create
      resource_path = "/projects/#{project_id}/tickets"
      Request.post(resource_path, self.to_xml('ticket'))
    end

  end
end