require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Generate documentation for the amazon-product-advertising-api gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AmazonProductAdvertisingApi'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = "amazon-product-advertising-api"
    gemspec.summary     = "A nice rubyish interface to the Amazon Product Advertising API."
    gemspec.email       = "jon@completelynovel.com"
    gemspec.homepage    = "http://github.com/completelynovel/amazon-product-advertising-api"
    gemspec.description = "A nice rubyish interface to the Amazon Product Advertising API, formerly known as the Associates Web Service and before that the Amazon E-Commerce Service."
    gemspec.authors     = ["Jon Gilbraith"]
    gemspec.add_dependency("hpricot")
    gemspec.add_dependency("ruby-hmac")
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

