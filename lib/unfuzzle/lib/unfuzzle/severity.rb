module Unfuzzle
  
  # = Severity
  #
  # Represents a Severity in an Unfuddle project.  These are user-configurable
  # and are custom for each project you have.  Examples include 'Story',
  # 'Defect', etc..  A severity has the following attributes:
  #
  # [id] The unique identifier for this severity
  # [name] The name of this severity
  # [created_at] The date/time that this severity was created
  # [updated_at] The date/time that this severity was last updated
  #
  class Severity
    
    include Graft
    
    attribute :id, :type => :integer
    attribute :name
    attribute :project_id, :from => 'project-id', :type => :integer
    attribute :created_at, :from => 'created-at', :type => :time
    attribute :updated_at, :from => 'updated-at', :type => :time
    
    # Find the severity by ID for a given project
    def self.find_by_project_id_and_severity_id(project_id, severity_id)
      response = Request.get("/projects/#{project_id}/severities/#{severity_id}")
      new response.body
    end
    
  end
end