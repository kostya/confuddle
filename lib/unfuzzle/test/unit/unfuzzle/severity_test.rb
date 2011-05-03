require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class SeverityTest < Test::Unit::TestCase
    
    context "The Severity class" do
      
      should "be able to return a severity for a project and severity id" do
        project_id  = 1
        severity_id = 1
        
        response = mock_request_cycle :for => "/projects/#{project_id}/severities/#{severity_id}", :data => 'severity'

        Unfuzzle::Severity.expects(:new).with(response.body).returns('severity')
        
        Unfuzzle::Severity.find_by_project_id_and_severity_id(project_id, severity_id).should == 'severity'
      end
      
    end
    
    context "An instance of the Severity class" do
      
      when_populating Severity, :from => 'severity' do

        value_for :id,          :is => 1
        value_for :name,        :is => 'Story'
        value_for :project_id,  :is => 2
        value_for :created_at,  :is => Time.parse('2009-04-02T19:44:49Z')
        value_for :updated_at,  :is => Time.parse('2009-04-02T19:44:49Z')
        
      end
      
    end
    
  end
end