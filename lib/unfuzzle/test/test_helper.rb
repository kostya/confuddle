# http://sneaq.net/textmate-wtf
$:.reject! { |e| e.include? 'TextMate' }

require 'rubygems'
require 'throat_punch'

require File.dirname(__FILE__) + '/../lib/unfuzzle'


class Test::Unit::TestCase
  
  def self.read_fixture(method_name)
    file = File.dirname(__FILE__) + "/fixtures/#{method_name}.xml"
    File.read(file)
  end

  def read_fixture(method_name)
    self.class.read_fixture(method_name)
  end
  
  def mock_request_cycle(options)
    response = Unfuzzle::Response.new(stub())

    data = read_fixture(options[:data])

    response.stubs(:body).with().returns(data)

    Unfuzzle::Request.stubs(:get).with(options[:for]).returns(response)

    response
  end

  def self.when_populating(klass, options, &block)
    context "with data populated for #{klass}" do
      setup { @object = klass.new(read_fixture(options[:from])) }
      merge_block(&block)
    end

  end

  def self.value_for(method_name, options)
    should "have a value for :#{method_name}" do
      @object.send(method_name).should == options[:is]
    end
  end
  
  def self.should_set_a_value_for(attribute, value = nil)
    class_name = self.to_s.sub(/^Unfuzzle::(.*)Test$/, '\\1')
    klass = Unfuzzle.const_get(class_name)
    
    value = attribute if value.nil?
    
    should "be able to set a value for :#{attribute}" do
      object = klass.new
      object.send("#{attribute}=", value)
      object.send(attribute).should == value
    end      
  end
  
end