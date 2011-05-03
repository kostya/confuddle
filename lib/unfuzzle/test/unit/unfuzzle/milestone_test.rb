require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class MilestoneTest < Test::Unit::TestCase

    context "The Milestone class" do

      should "be able to find all by project ID" do
        project_id = 1

        response = mock_request_cycle :for => "/projects/#{project_id}/milestones", :data => 'milestones'

        Unfuzzle::Milestone.expects(:collection_from).with(response.body, 'milestones/milestone').returns(['milestone_1', 'milestone_2'])

        Milestone.find_all_by_project_id(project_id).should == ['milestone_1', 'milestone_2']
      end
      
      should "be able to find one by project ID an milestone ID" do
        project_id    = 1
        milestone_id  = 2
        response = mock_request_cycle :for => "/projects/#{project_id}/milestones/#{milestone_id}", :data => 'milestone'
        
        Unfuzzle::Milestone.expects(:new).with(response.body).returns('milestone')
        
        Milestone.find_by_project_id_and_milestone_id(1, 2).should == 'milestone'
      end

    end

    context "An instance of the Milestone class" do

      when_populating Milestone, :from => 'milestone' do

        value_for :id,          :is => 2
        value_for :project_id,  :is => 1
        value_for :archived,    :is => false
        value_for :created_at,  :is => Time.parse('2009-04-02T19:43:16Z')
        value_for :name,        :is => 'Milestone #1'
        value_for :due_on,      :is => Date.parse('2009-04-03')
        value_for :updated_at,  :is => Time.parse('2009-07-02T16:40:28Z')

      end

      context "with a new instance" do

        setup { @milestone = Milestone.new }

        should "know that it is archived" do
          @milestone.stubs(:archived).with().returns(true)
          @milestone.archived?.should be(true)
        end

        should "know that it isn't archived" do
          @milestone.stubs(:archived).with().returns(false)
          @milestone.archived?.should be(false)
        end

        should "have associated tickets" do
          id         = 1
          project_id = 1

          Ticket.expects(:find_all_by_project_id_and_milestone_id).with(project_id, id).returns('tickets')

          @milestone.stubs(:id).with().returns(id)
          @milestone.stubs(:project_id).with().returns(project_id)

          @milestone.tickets.should == 'tickets'
        end
        
        should "know that it's in the past if the due date is in the past" do
          due_date = Date.today
          today    = due_date.next
          
          @milestone.stubs(:due_on).with().returns(due_date)
          Date.expects(:today).with().returns(today)
          
          @milestone.past?.should be(true)
        end
        
        should "know that it's not in the past if the date is today" do
          due_date = Date.today
          @milestone.stubs(:due_on).with().returns(due_date)
          
          @milestone.past?.should be(false)
        end
        
        should "know that it's not in the past if the due date is in the future" do
          due_date = Date.today.next
          @milestone.stubs(:due_on).with().returns(due_date)
          
          @milestone.past?.should be(false)
        end
        

      end

    end

  end
end
