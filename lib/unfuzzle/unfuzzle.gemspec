# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{unfuzzle}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Patrick Reagan", "Bob Lail"]
  s.date = %q{2010-12-22}
  s.email = %q{patrick.reagan@viget.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "Rakefile", "lib/unfuzzle", "lib/unfuzzle/component.rb", "lib/unfuzzle/milestone.rb", "lib/unfuzzle/priority.rb", "lib/unfuzzle/project.rb", "lib/unfuzzle/request.rb", "lib/unfuzzle/response.rb", "lib/unfuzzle/severity.rb", "lib/unfuzzle/ticket.rb", "lib/unfuzzle/version.rb", "lib/unfuzzle.rb", "test/fixtures", "test/fixtures/component.xml", "test/fixtures/components.xml", "test/fixtures/milestone.xml", "test/fixtures/milestones.xml", "test/fixtures/project.xml", "test/fixtures/projects.xml", "test/fixtures/severities.xml", "test/fixtures/severity.xml", "test/fixtures/ticket.xml", "test/fixtures/tickets.xml", "test/test_helper.rb", "test/unit", "test/unit/unfuzzle", "test/unit/unfuzzle/component_test.rb", "test/unit/unfuzzle/milestone_test.rb", "test/unit/unfuzzle/priority_test.rb", "test/unit/unfuzzle/project_test.rb", "test/unit/unfuzzle/request_test.rb", "test/unit/unfuzzle/response_test.rb", "test/unit/unfuzzle/severity_test.rb", "test/unit/unfuzzle/ticket_test.rb", "test/unit/unfuzzle_test.rb"]
  s.homepage = %q{http://www.viget.com/extend}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{This gem provides an interface to the Unfuddle XML API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<graft>, [">= 0.1.1"])
    else
      s.add_dependency(%q<graft>, [">= 0.1.1"])
    end
  else
    s.add_dependency(%q<graft>, [">= 0.1.1"])
  end
end
