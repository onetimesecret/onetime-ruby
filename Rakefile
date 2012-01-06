require "rubygems"
require "rake"
require "rake/clean"
require 'yaml'

require 'hanna/rdoctask'
 
config = YAML.load_file("VERSION.yml")
task :default => ["build"]
CLEAN.include [ 'pkg', 'doc' ]
name = "onetime"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.version = "#{config[:MAJOR]}.#{config[:MINOR]}.#{config[:PATCH]}"
    gem.name = name
    gem.executables = ['onetime']
    gem.rubyforge_project = gem.name
    gem.summary = "CLI tool and Ruby library for onetimesecret.com"
    gem.description = "CLI tool and Ruby library for onetimesecret.com"
    gem.email = "delano@onetimesecret.com"
    gem.homepage = "https://github.com/onetimesecret/onetime-ruby"
    gem.authors = ["Delano Mandelbaum"]
    gem.add_dependency('drydock',       '>= 0.6.9')
    gem.add_dependency('httparty',      '>= 0.7.7')
    gem.add_dependency('json',          '>= 1.6.4')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end


Rake::RDocTask.new do |rdoc|
  version = "#{config[:MAJOR]}.#{config[:MINOR]}.#{config[:PATCH]}"
  rdoc.rdoc_dir = "doc"
  rdoc.title = "#{name} #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("LICENSE.txt")
  rdoc.rdoc_files.include("bin/*.rb")
  rdoc.rdoc_files.include("lib/**/*.rb")
end


