require File.dirname(__FILE__) + '/../../test_helper'

module Graft
  module Xml

    class StringTest < Test::Unit::TestCase
      context "An instance of the Graft::Xml::Type::String class" do

        should_convert 'a string', :to => 'a string'
        should_convert '',         :to => nil

      end
    end

    class BooleanTest < Test::Unit::TestCase
      context "An instance of the Graft::Xml::Type::Boolean class" do

        should_convert 'true',  :to => true
        should_convert 'false', :to => false
        should_convert '0',     :to => false
        should_convert '1',     :to => true
        should_convert '',      :to => nil

        should_fail_when_converting 'foo'

      end
    end

    class IntegerTest < Test::Unit::TestCase
      context "An instance of the Graft::Xml::Type::Integer class" do

        should_convert '1', :to => 1
        should_convert '',  :to => nil

        should_fail_when_converting 'foo'

      end
    end

    class DateTest < Test::Unit::TestCase

      context "An instance of the Graft::Xml::Type::Date class" do

        should_convert '2008-08-01', :to => Date.parse('2008-08-01')
        should_convert '',           :to => nil

      end

    end

    class TimeTest < Test::Unit::TestCase

      context "An instance of the Graft::Xml::Type::Time class" do

        should_convert '2008-07-28T16:57:10Z', :to => Time.parse('2008-07-28T16:57:10Z')
        should_convert '2008-12-25 18:26:55',  :to => Time.parse('2008-12-25 18:26:55')
        should_convert '1230274722',           :to => Time.at(1230274722)
        should_convert '',                     :to => nil

      end

    end

  end
end