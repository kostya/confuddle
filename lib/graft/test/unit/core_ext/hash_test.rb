require File.dirname(__FILE__) + '/../../test_helper'

class HashTest < Test::Unit::TestCase
  
  context "An instance of Hash" do
    
    should "be able to extract a value using the / operator" do
      hash = {'key' => 'value'}
      (hash/'key').should == 'value'
    end
    
    should "be able to extract nested values using the / operator" do
      hash = {'user' => {'name' => 'luser'}}
      (hash/'user/name').should == 'luser'
    end
    
    should "return nil when attempting to extract a value that doesn't exist" do
      hash = {'user' => {'name' => 'luser'}}
      (hash/'user/username').should be(nil)
    end
    
    should "be able to fetch a value using a symbol" do
      hash = {'key' => 'value'}
      (hash/:key).should == 'value'
    end
    
  end
  
end