require "rubygems"
require "rake"
require "rake/clean"
require "rdoc/task"

task :default => ["build"]
CLEAN.include [ 'pkg', 'rdoc' ]
name = "onetime/api"

$:.unshift File.join(File.dirname(__FILE__), 'lib')
require name
version = Onetime::API::VERSION.to_s

begin
  require "jeweler"
  Jeweler::Tasks.new do |s|
    s.version = version
    s.name = "onetime"
    s.executables = ['onetime']
    s.summary = "Command-line tool and library for onetimesecret.com API"
    s.description = "Command-line tool and library for onetimesecret.com API"
    s.email = "delano@onetimesecret.com"
    s.homepage = "https://github.com/onetimesecret/onetime-ruby"
    s.authors = ["Delano Mandelbaum"]
    s.add_dependency('drydock',       '>= 0.6.9')
    s.add_dependency('httparty',      '>= 0.7.7')
    s.add_dependency('json',          '>= 1.6.8')

    s.signing_key = File.join('/mnt/gem/', 'gem-private_key.pem')
    s.cert_chain  = ['gem-public_cert.pem']
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "#{name} #{version}"
  rdoc.generator = 'hanna'
  rdoc.main = 'README.rdoc'
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("LICENSE.txt")
  rdoc.rdoc_files.include("VERSION")
  rdoc.rdoc_files.include("bin/*.rb")
  rdoc.rdoc_files.include("lib/**/*.rb")
end



