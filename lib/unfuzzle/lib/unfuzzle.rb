$:.unshift File.dirname(__FILE__)

require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'builder'
require File.dirname(__FILE__) + '/../../graft/lib/graft/xml'

Dir[File.dirname(__FILE__) + "/unfuzzle/*.rb"].each { |x| require x }

# = Unfuzzle: A simple wrapper around the Unfuddle JSON API
#
# == Quick Start
#
# To get started, you need to set the subdomain and a valid username / 
# password combination:
#
#    require 'rubygems'
#    require 'unfuzzle'
#
#    Unfuzzle.subdomain = 'viget'
#    Unfuzzle.username = 'bopbip'
#    Unfuzzle.password = 'bleep'
# 
# From there, you can start accessing a list of projects:
#
#   >> Unfuzzle.projects
#   => [#<Unfuzzle::Project:0x5f5c44 @id=1, @name="BlipCo", ...>, ... ]
#
# Or a specific project by its 'short name':
#
#   >> Unfuzzle.project('sample')
#   => #<Unfuzzle::Project:0x123f888 @id=2, @name="Sample Project", ... >
#
# For more usage documentation, see README.doc.
#
module Unfuzzle
  
  # Set the subdomain for all requests
  def self.subdomain=(subdomain)
    @subdomain = subdomain
  end

  # Set the username for all requests. Data retrieved from the API will be
  # scoped to the data that this user has access to.
  def self.username=(username)
    @username = username
  end

  # Set the password for the supplied username
  def self.password=(password)
    @password = password
  end
  
  # Use SSL: yes or no
  def self.use_ssl=(value)
    @use_ssl = value
  end
  
  # Retrieve a project for the current user by its ID or slug
  def self.project(id_or_slug)
    id_or_slug.is_a?(String) ? Project.find_by_slug(id_or_slug) : Project.find_by_id(id_or_slug)
  end
  
  # Get a list of all projects for this user
  def self.projects
    Project.all
  end
    
  def self.subdomain # :nodoc:
    @subdomain
  end
  
  def self.username # :nodoc:
    @username
  end
  
  def self.password # :nodoc:
    @password
  end
  
  def self.use_ssl # :nodoc:
    @use_ssl
  end
  
end