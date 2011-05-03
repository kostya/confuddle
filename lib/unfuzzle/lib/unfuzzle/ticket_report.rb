module Unfuzzle

  # = Project
  #
  # Represents an Unfuddle project.  Has the following attributes:
  #
  # [id] The unique identifier for this project
  # [slug] The "short name" for this project
  # [name] The name of this project
  # [description] The description for the project
  # [archived] The archived status of this project (see Project#archived?)
  # [created_at] The date/time that this project was created
  # [updated_at] The date/time that this project was last updated
  #
  class TicketReport

    include Graft

    attribute :id, :type => :integer
    attribute :relationship
    attribute :title
    
    def self.all
      response = Request.get('/ticket_reports')
      collection_from(response.body, 'ticket-report')
    end
  end

end
