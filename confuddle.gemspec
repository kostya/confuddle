# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/version"

Gem::Specification.new do |s|
  s.name = %q{confuddle}
  s.version = Un::VERSION
  s.authors = ["Makarchev Konstantin"]
  s.description = %q{Utility for work with unfuddle.com account from console}
  s.summary = %q{Utility for work with unfuddle.com account from console}

  s.email = %q{kostya27@gmail.com}
  s.homepage = %q{http://github.com/kostya/confuddle}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_dependency 'activesupport', ">=2.3.2"
  s.add_dependency 'thor', ">=0.14.3"
  s.add_dependency 'hpricot'
  s.add_dependency 'tzinfo'
  s.add_dependency 'builder'
  
end
