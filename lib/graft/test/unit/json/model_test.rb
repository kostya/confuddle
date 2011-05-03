require File.dirname(__FILE__) + '/../../test_helper'

class EmptyJsonModel
  include Graft::Json::Model
end

class JsonModelWithAttributes
  include Graft::Json::Model

  attribute :name
  attribute :description, :from => 'desc'
  attribute :rating,      :from => 'rsp/rating'
end

class JsonModelTest < Test::Unit::TestCase

  context "The EmptyJsonModel class" do
    should "have an empty list of attributes if none are supplied" do
      EmptyJsonModel.attributes.should == []
    end
    
    should "be able to return a collection of instances" do
      json_data = '{"results":[{"name":"one"},{"name":"two"}]}'
      
      EmptyJsonModel.expects(:new).with({'name' => 'one'}).returns('model_1')
      EmptyJsonModel.expects(:new).with({'name' => 'two'}).returns('model_2')
      
      collection = EmptyJsonModel.collection_from(json_data, 'results')
      collection.should == ['model_1', 'model_2']
    end
    
    should "be able to retrieve data from the source JSON string" do
      json_data = '{"name":"Graft"}'
      EmptyJsonModel.data_from(json_data).should == {'name' => 'Graft'}
    end
    
    should "be able to retrieve data from the source hash data" do
      data = {'name' => 'Graft'}
      EmptyJsonModel.data_from(data).should == {'name' => 'Graft'}
    end
  end

  context "The JsonModelWithAttributes class" do
    should "know the names of all its attributes" do
      JsonModelWithAttributes.attributes.map {|a| a.name.to_s }.should == %w(name description rating)
    end
  end
  
  context "An instance of the JsonModelWithAttributes class" do
    
    should "assign attributes upon initialization" do
      json_data = '{"name":"Graft"}'
      JsonModelWithAttributes.new(json_data).name.should == 'Graft'
    end
    
    should "have a reference to the original source data" do
      json_data = '{"name":"Graft"}'
      data = JSON.parse(json_data)
      
      m = JsonModelWithAttributes.new(json_data)
      m.source_data.should == data
    end
    
    context "when populating from JSON data" do
      setup do
        json_data = '{"name":"Graft", "desc":"library", "rsp":{"rating":10}}'
        @model = JsonModelWithAttributes.new
        @model.populate_from(json_data)
      end

      should "have a value for :name" do
        @model.name.should == 'Graft'
      end

      should "have a value for :description" do
        @model.description.should == 'library'
      end

      should "have a value for :rating" do
        @model.rating.should == 10
      end
    end
    
  end
  
end