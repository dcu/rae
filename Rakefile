require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rae"
    gem.summary = %Q{CLI to access the rae.es}
    gem.description = %Q{CLI to access the rae.es}
    gem.email = "koldo.oteo1@gmail.com"
    gem.homepage = "http://koteo.lacoctelera.net/post/2009/11/18/acceder-al-diccionario-la-rae-con-ruby"
    gem.authors = ["Koldo Oteo"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"

    gem.add_dependency('mechanize', '>= 0.9.3')
    gem.add_dependency('nokogiri', '>= 1.3.3')
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rae #{version}"
  rdoc.rdoc_files.include('README*')
end
