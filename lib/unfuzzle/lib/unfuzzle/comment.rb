module Unfuzzle

  #
  class Comment

    include Graft
    
    attribute :created_at
    attribute :body
    attribute :author_id, :from => "author-id", :type => :integer
    
    # Return a list of all tickets for an individual project
    def self.all_by_project_and_ticket(project_id, ticket_id)
      response = Request.get("/projects/{id}/tickets/{id}/comments")
      collection_from(response.body, 'comments/comment')
    end
    
  end
end
  
  