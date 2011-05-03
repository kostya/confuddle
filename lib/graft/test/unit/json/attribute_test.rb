require File.dirname(__FILE__) + '/../../test_helper'

module Graft
  module Json
    class AttributeTest < Test::Unit::TestCase

      context "An instance of the Graft::Json::Attribute class" do

        should "know its name" do
          attr = Graft::Json::Attribute.new(:foo)
          attr.name.should == :foo
        end

        should "have a default source" do
          attr = Graft::Json::Attribute.new(:foo)
          attr.source.should == 'foo'
        end

        should "be able to extract a value from a hash" do
          data = {"first_name" => "Richerd"}

          attr = Graft::Json::Attribute.new(:first_name)
          attr.value_from(data).should == 'Richerd'
        end
        
        should "be able to extract a value from a hash when provided with a symbol for the source" do
          data = {"firstname" => "Richerd"}
          
          attr = Graft::Json::Attribute.new(:first_name, :firstname)
          attr.value_from(data).should == 'Richerd'
        end

        should "be able to extract a nested value from a JSON string" do
          data = {"user" => {"first_name" => "Richerd"}}

          attr = Graft::Json::Attribute.new(:first_name, 'user/first_name')
          attr.value_from(data).should == 'Richerd'
        end

        should "return nil when the value doesn't exist" do
          data = {"first_name" => "Richerd"}

          attr = Graft::Json::Attribute.new(:last_name, 'last_name')
          attr.value_from(data).should be(nil)
        end

      end

    end
  end
end