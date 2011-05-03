$:.unshift File.dirname(__FILE__) + '/..'

require 'hpricot'
require 'builder'
require 'tzinfo'

require 'active_support/time_with_zone'
require 'active_support/inflector'

require 'graft/model'
require 'graft/xml/type'
require 'graft/xml/attribute'
require 'graft/xml/model'

module Graft
  def self.included(other)
    other.send(:include, Graft::Xml::Model)
  end
end
