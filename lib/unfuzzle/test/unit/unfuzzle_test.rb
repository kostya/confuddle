require File.dirname(__FILE__) + '/../test_helper'

class UnfuzzleTest < Test::Unit::TestCase

  context "The Unfuzzle module" do
    
    should "be able to set the subdomain" do
      Unfuzzle.subdomain = 'viget'
      Unfuzzle.subdomain.should == 'viget'
    end
    
    should "be able to set the username" do
      Unfuzzle.username = 'username'
      Unfuzzle.username.should == 'username'
    end
    
    should "be able to set the password" do
      Unfuzzle.password = 'password'
      Unfuzzle.password.should == 'password'
    end
    
    should "be able to retrieve a project by id" do
      Unfuzzle::Project.expects(:find_by_id).with(1).returns('project')
      Unfuzzle.project(1).should == 'project'
    end
    
    should "be able to retrieve a project by slug" do
      Unfuzzle::Project.expects(:find_by_slug).with('slug').returns('project')
      Unfuzzle.project('slug').should == 'project'
    end
    
    should "be able to retrieve a list of all projects for the current user" do
      Unfuzzle::Project.expects(:all).with().returns('projects')
      Unfuzzle.projects.should == 'projects'
    end
    
  end
  
end