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
