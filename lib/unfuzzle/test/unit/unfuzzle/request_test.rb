require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class RequestTest < Test::Unit::TestCase
    
    context "The Request class" do
      
      should "be able to perform a GET request" do
        request = mock() {|r| r.expects(:get).with().returns('response') }
        Unfuzzle::Request.expects(:new).with('/projects').returns(request)
        
        Unfuzzle::Request.get('/projects').should == 'response'
      end
      
      should "be able to perform a PUT request" do
        request = mock() {|r| r.expects(:put).with().returns('response') }
        Unfuzzle::Request.expects(:new).with('/projects', '<payload>').returns(request)
        
        Unfuzzle::Request.put('/projects', '<payload>').should == 'response'
      end
      
    end
    
    context "An instance of the Request class" do

      should "have an endpoint URI" do
        Unfuzzle.stubs(:subdomain).with().returns('viget')
        
        request = Unfuzzle::Request.new('/projects')
        request.endpoint_uri.should == URI.parse('http://viget.unfuddle.com/api/v1/projects.xml')
      end
      
      should "have an endpoint URI with the appropriate format when specified" do
        Unfuzzle.stubs(:subdomain).with().returns('viget')
        
        request = Unfuzzle::Request.new('/projects', nil)
        request.endpoint_uri.should == URI.parse('http://viget.unfuddle.com/api/v1/projects.xml')
      end
      
      should "have a client" do
        client = stub()
        
        request = Unfuzzle::Request.new('/projects')
        request.stubs(:endpoint_uri).with().returns(URI.parse('http://example.com'))
        
        Net::HTTP.expects(:new).with('example.com').returns(client)
        
        request.client.should == client
      end
      
      should "be able to perform a GET request" do
        Unfuzzle.stubs(:username).with().returns('username')
        Unfuzzle.stubs(:password).with().returns('password')
        
        request = Unfuzzle::Request.new('/projects')
        request.stubs(:endpoint_uri).returns(URI.parse('http://example.com/projects'))
        
        get_request = mock() do |g|
          g.expects(:basic_auth).with('username', 'password')
        end
        
        client = mock() {|c| c.expects(:request).with(get_request).returns('response') }
        
        response = stub()
        Unfuzzle::Response.expects(:new).with('response').returns(response)
        
        Net::HTTP::Get.expects(:new).with('/projects').returns(get_request)
        
        request.stubs(:client).with().returns(client)
        
        request.get.should == response
      end
      
      should "be able to perform a PUT request" do
        Unfuzzle.stubs(:username).with().returns('username')
        Unfuzzle.stubs(:password).with().returns('password')
        
        request_body = '<payload>'
        
        request = Unfuzzle::Request.new('/projects', request_body)
        
        request.stubs(:endpoint_uri).returns(URI.parse('http://example.com/projects'))
        
        put_request = mock() do |p|
          p.expects(:basic_auth).with('username', 'password')
          p.expects(:content_type=).with('application/xml')
        end
        
        client = mock() {|c| c.expects(:request).with(put_request, request_body).returns('response') }
        
        response = stub()
        Unfuzzle::Response.expects(:new).with('response').returns(response)
        
        Net::HTTP::Put.expects(:new).with('/projects').returns(put_request)
        
        request.stubs(:client).with().returns(client)
        
        request.put.should == response
      end
      
    end
    
  end
end