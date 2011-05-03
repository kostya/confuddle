require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class ComponentTest < Test::Unit::TestCase
    
    context "The Component class" do
      
      should "be able to return a severity for a project and component id" do
        project_id   = 1
        component_id = 1

        response = mock_request_cycle :for => "/projects/#{project_id}/components/#{component_id}", :data => 'component'

        Unfuzzle::Component.expects(:new).with(response.body).returns('component')
        
        Unfuzzle::Component.find_by_project_id_and_component_id(project_id, component_id).should == 'component'
      end
      
    end
    
    context "An instance of the Component class" do
      
      when_populating Component, :from => 'component' do
      
        value_for :id,          :is => 1
        value_for :name,        :is => 'Administration'
        value_for :project_id,  :is => 2
        value_for :created_at,  :is => Time.parse('2009-06-15T20:40:29Z')
        value_for :updated_at,  :is => Time.parse('2009-06-15T20:40:29Z')

      end
      
    end
    
  end
end