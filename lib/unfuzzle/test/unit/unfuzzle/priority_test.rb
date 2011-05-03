require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class PriorityTest < Test::Unit::TestCase

    def self.should_have_a_name_of(name, options)
      should "have a name of '#{name}' when the priority is #{options[:when]}" do
        p = Priority.new(options[:when])
        p.name.should == name
      end
    end
      
    
    context "An instance of the Priority class" do
      
      should_have_a_name_of 'Highest',  :when => 5
      should_have_a_name_of 'High',     :when => 4
      should_have_a_name_of 'Normal',   :when => 3
      should_have_a_name_of 'Low',      :when => 2
      should_have_a_name_of 'Lowest',   :when => 1
      
    end
    
  end
end