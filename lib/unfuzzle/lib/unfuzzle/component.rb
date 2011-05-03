module Unfuzzle
  
  # = Component
  #
  # Represents a Component in an Unfuddle project.  These are user-configurable
  # and are custom for each project you have.  Examples include 'Administration',
  # 'User Registration', etc..  A component has the following attributes:
  #
  # [id] The unique id for this component
  # [name] The name of this component (e.g User Registration)
  # [created_at] The date/time that this component was created
  # [updated_at] The date/time that this component was last updated
  #
  class Component
    
    include Graft
    
    attribute :id, :type => :integer
    attribute :name
    attribute :project_id, :from => 'project-id', :type => :integer
    attribute :created_at, :from => 'created-at', :type => :time
    attribute :updated_at, :from => 'updated-at', :type => :time
    
    # Find a component by ID for a given project
    def self.find_by_project_id_and_component_id(project_id, component_id)
      response = Request.get("/projects/#{project_id}/components/#{component_id}")
      new response.body
    end
    
  end
end