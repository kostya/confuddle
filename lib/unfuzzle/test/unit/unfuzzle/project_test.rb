require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class ProjectTest < Test::Unit::TestCase

    context "The Project class" do

      should "be able to return a list of all projects" do
        response = mock_request_cycle :for => '/projects', :data => 'projects'
      
        Unfuzzle::Project.expects(:collection_from).with(response.body, 'projects/project').returns(['project_1', 'project_2'])
      
        Project.all.should == ['project_1', 'project_2']
      end

      should "be able to find a project by its slug" do
        slug = 'blip'

        response = mock_request_cycle :for => "/projects/by_short_name/#{slug}", :data => 'project'

        Unfuzzle::Project.expects(:new).with(response.body).returns('project')

        Project.find_by_slug(slug).should == 'project'
      end

      should "be able to find a project by its ID" do
        id = 1

        response = mock_request_cycle :for => "/projects/#{id}", :data => 'project'

        Unfuzzle::Project.expects(:new).with(response.body).returns('project')

        Project.find_by_id(id).should == 'project'
      end


    end

    context "An instance of the Project class" do

      when_populating Project, :from => 'project' do
      
        value_for :id,          :is => 1
        value_for :archived,    :is => false
        value_for :slug,        :is => 'blip'
        value_for :name,        :is => 'Blip Bleep Co.'
        value_for :description, :is => 'This is the project for Blip Bleep Co.'
        value_for :created_at,  :is => Time.parse('2008-07-28T16:57:10Z')
        value_for :updated_at,  :is => Time.parse('2009-04-28T18:48:52Z')
      
      end

      context "with a new instance" do

        setup { @project = Project.new }

        should "know that it's archived" do
          @project.stubs(:archived).with().returns(true)
          @project.archived?.should be(true)
        end

        should "know that it's not archived" do
          @project.stubs(:archived).with().returns(false)
          @project.archived?.should be(false)
        end

        should "have a list of associated milestones" do
          id = 1
          Milestone.expects(:find_all_by_project_id).with(id).returns('milestones')

          @project.stubs(:id).with().returns(id)
          @project.milestones.should == 'milestones'
        end

        should "have a list of associated tickets" do
          id = 1
          Ticket.expects(:find_all_by_project_id).with(id).returns('tickets')

          @project.stubs(:id).with().returns(id)
          @project.tickets.should == 'tickets'
        end
        
      end
    end

  end
end