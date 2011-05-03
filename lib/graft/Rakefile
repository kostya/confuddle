require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

require 'lib/graft/version'

task :default => :test

spec = Gem::Specification.new do |s|
  s.name             = 'graft'
  s.version          = Graft::Version.to_s
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.rdoc)
  s.rdoc_options     = %w(--main README.rdoc)
  s.summary          = "Graft provides an easy way to map XML and JSON data onto your Ruby classes"
  s.author           = 'Patrick Reagan'
  s.email            = 'reaganpr@gmail.com'
  s.homepage         = 'http://sneaq.net/'
  s.files            = %w(README.rdoc Rakefile) + Dir.glob("{lib,test}/**/*")
  
  s.add_dependency('hpricot', '>= 0.6.164')
  s.add_dependency('tzinfo', '>= 0.3.12')
  s.add_dependency('builder', '>= 2.1.2')
  s.add_dependency('activesupport', '>= 2.0')
  s.add_dependency('json', '>= 1.1.7')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

desc 'Generate the gemspec to serve this Gem from Github'
task :github do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, 'w') {|f| f << spec.to_ruby }
  puts "Created gemspec: #{file}"
end