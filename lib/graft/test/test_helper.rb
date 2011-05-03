# http://sneaq.net/textmate-wtf
$:.reject! { |e| e.include? 'TextMate' }

require 'rubygems'
require 'throat_punch'

require File.dirname(__FILE__) + '/../lib/graft/xml'
require File.dirname(__FILE__) + '/../lib/graft/json'

class Test::Unit::TestCase
  
  def self.implementation_klass
    class_name = self.to_s.match(/([a-zA-Z]+)Test$/)[1]
    klass      = Graft::Xml::Type.const_get(class_name)
    
    klass
  end
  
  def self.should_convert(source, options)
    klass  = self.implementation_klass
    target = options[:to]

    should "be able to convert '#{source}' to #{target}" do
      o = klass.new(source)
      o.value.should == target
    end
  end
  
  def self.should_fail_when_converting(source)
    klass = self.implementation_klass
    
    should "fail when converting '#{source}'" do
      o = klass.new(source)
      lambda { o.value }.should raise_error(Graft::Xml::Type::ConversionError)
    end
  end
  
end