require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class TicketTest < Test::Unit::TestCase

    context "The Ticket class" do

      should "be able to return a list of tickets for a project" do
        project_id = 1

        response = mock_request_cycle :for => "/projects/#{project_id}/tickets", :data => 'tickets'

        Unfuzzle::Ticket.expects(:collection_from).with(response.body, 'tickets/ticket').returns(['ticket_1', 'ticket_2'])

        Ticket.find_all_by_project_id(project_id).should == ['ticket_1', 'ticket_2']
      end

      should "be able to return a list of tickets for a milestone" do
        milestone_id = 1
        project_id   = 1

        response = mock_request_cycle :for => "/projects/#{project_id}/milestones/#{milestone_id}/tickets", :data => 'tickets'

        Unfuzzle::Ticket.expects(:collection_from).with(response.body, 'tickets/ticket').returns(['ticket_1', 'ticket_2'])
        
        Ticket.find_all_by_project_id_and_milestone_id(project_id, milestone_id).should == ['ticket_1', 'ticket_2']
      end

    end

    context "An instance of the Ticket class" do

      when_populating Ticket, :from => 'ticket' do

        value_for :id,                :is => 1
        value_for :project_id,        :is => 1
        value_for :milestone_id,      :is => 1
        value_for :severity_id,       :is => 123
        value_for :priority_id,       :is => 3
        value_for :component_id,      :is => 1
        value_for :created_at,        :is => Time.parse('2008-11-25T14:00:19Z')
        value_for :updated_at,        :is => Time.parse('2008-12-31T15:51:41Z')
        value_for :number,            :is => '1'
        value_for :title,             :is => 'Ticket #1'
        value_for :description,       :is => 'Do something important'
        value_for :due_on,            :is => nil
        value_for :status,            :is => 'closed'

      end
      
      should_set_a_value_for :title
      should_set_a_value_for :description
      
      context "with a new instance" do
        setup { @ticket = Ticket.new }

        should "have a due date" do
          xml = '<ticket><due-on>2009-08-01</due-on></ticket>'
          
          ticket = Ticket.new(xml)
          ticket.due_on.should == Date.parse('2009-08-01')
        end
        
        should "have an associated milestone" do
          Milestone.expects(:find_by_project_id_and_milestone_id).with(1, 2).returns('milestone')
          
          @ticket.stubs(:project_id).with().returns(1)
          @ticket.stubs(:milestone_id).with().returns(2)
          
          @ticket.milestone.should == 'milestone'
        end
        
        should "have an associated severity" do
          project_id  = 1
          severity_id = 1

          Severity.expects(:find_by_project_id_and_severity_id).with(project_id, severity_id).returns('severity')
          
          @ticket.stubs(:project_id).with().returns(project_id)
          @ticket.stubs(:severity_id).with().returns(severity_id)
          
          @ticket.severity.should == 'severity'
        end
        
        should "have no associated severity if it is not set" do
          @ticket.stubs(:severity_id).with().returns(nil)
          @ticket.severity.should be(nil)
        end
        
        should "have a severity_name" do
          @ticket.stubs(:severity).with().returns(stub(:name => 'Story'))
          @ticket.severity_name.should == 'Story'
        end
        
        should "have no severity_name if there is no severity" do
          @ticket.stubs(:severity).with().returns(nil)
          @ticket.severity_name.should be(nil)
        end
        
        should "have an associated priority" do
          Priority.expects(:new).with(1).returns('priority')
          
          @ticket.stubs(:priority_id).with().returns(1)
          @ticket.priority.should == 'priority'
        end
        
        should "have a priority_name" do
          @ticket.stubs(:priority).with().returns(stub(:name => 'High'))
          @ticket.priority_name.should == 'High'
        end
        
        should "have an associated component" do
          project_id  = 1
          component_id = 1

          Component.expects(:find_by_project_id_and_component_id).with(project_id, component_id).returns('component')
          
          @ticket.stubs(:project_id).with().returns(project_id)
          @ticket.stubs(:component_id).with().returns(component_id)
          
          @ticket.component.should == 'component'
        end

        should "have no associated component if it is not set" do
          @ticket.stubs(:component_id).with().returns(nil)
          @ticket.component.should be(nil)
        end
        
        should "have a component_name" do
          @ticket.stubs(:component).with().returns(stub(:name => 'Admin'))
          @ticket.component_name.should == 'Admin'
        end
        
        should "have no component_name if there is no component" do
          @ticket.stubs(:component).with().returns(nil)
          @ticket.component_name.should be(nil)
        end
        
        should "be able to generate a hash representation of itself for updating" do
          @ticket.id           = 1
          @ticket.project_id   = 2
          @ticket.milestone_id = 3
          @ticket.number       = '12'
          @ticket.title        = 'summary'
          @ticket.description  = 'description'
          @ticket.status       = 'closed'

          
          expected = {
            'id'           => 1,
            'project_id'   => 2,
            'milestone_id' => 3,
            'number'       => '12',
            'summary'      => 'summary',
            'description'  => 'description',
            'status'       => 'closed'
          }
          
          @ticket.to_hash.should == expected          
        end
        
        should "be able to perform an update" do
          @ticket.stubs(:project_id).with().returns(1)
          @ticket.stubs(:id).with().returns(2)
          
          resource_path = '/projects/1/tickets/2'
          ticket_xml    = '<ticket />'
          
          @ticket.stubs(:to_xml).with('ticket').returns(ticket_xml)
          
          Unfuzzle::Request.expects(:put).with(resource_path, ticket_xml).returns('response')
          
          @ticket.update.should == 'response'
        end

      end

    end

  end
end
