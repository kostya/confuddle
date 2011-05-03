require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class ResponseTest < Test::Unit::TestCase
    
    context "An instance of the Response class" do
      
      should "delegate to the HTTP response to determine the body" do
        http_response = mock() {|r| r.expects(:body).with().returns('check mah boday') }
        
        response = Unfuzzle::Response.new(http_response)
        
        response.body.should == 'check mah boday'
      end
      
      should "know that there are no errors" do
        http_response = mock() do |r|
          r.expects(:is_a?).with(Net::HTTPSuccess).returns(true)
        end
        
        response = Unfuzzle::Response.new(http_response)
        response.error?.should be(false)
      end
      
      should "know if there are errors" do
        http_response = mock() do |r|
          r.expects(:is_a?).with(Net::HTTPSuccess).returns(false)
        end
        
        response = Unfuzzle::Response.new(http_response)
        response.error?.should be(true)
      end
      
    end
    
  end
end