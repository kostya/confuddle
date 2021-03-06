module Unfuzzle
  class Person
    include Graft
    attribute :id, :type => :integer
    attribute :first_name, :from => 'first-name'
    attribute :last_name, :from => 'last-name'
    attribute :username, :from => 'username'

    def self.all
      response = Request.get("/people")
      collection_from(response.body, 'people/person')
    end

    def self.all_for_project(project_id)
      response = Request.get("/projects/#{project_id}/people")
      collection_from(response.body, 'people/person')
    end

  end
end