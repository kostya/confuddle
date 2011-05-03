module Unfuzzle

  #
  class Comment

    include Graft

    attribute :id 
    attribute :created_at
    attribute :body
    attribute :author_id, :from => "author-id", :type => :integer
    
    # Hash representation of this ticket's data (for updating)
    def to_hash
      {
        'id'           => id,
        'body'         => body,
        'author-id'    => author_id
      }
    end
    
    # Return a list of all tickets for an individual project
    def self.all_by_project_and_ticket(project_id, ticket_id)
      response = Request.get("/projects/{id}/tickets/{id}/comments")
      collection_from(response.body, 'comments/comment')
    end
    
    # Create a comment
    def create(project_id, ticket_id)
      resource_path = "/projects/#{project_id}/tickets/#{ticket_id}/comments"
      Request.post(resource_path, self.to_xml('comment'))
    end
    
  end
end
  
  