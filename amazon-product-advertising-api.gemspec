# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{amazon-product-advertising-api}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jon Gilbraith"]
  s.date = %q{2009-07-06}
  s.description = %q{A nice rubyish interface to the Amazon Product Advertising API, formerly known as the Associates Web Service and before that the Amazon E-Commerce Service.}
  s.email = %q{jon@completelynovel.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "EXAMPLE.txt",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "amazon-product-advertising-api.gemspec",
     "lib/amazon_product_advertising_api.rb",
     "lib/amazon_product_advertising_api/base.rb",
     "lib/amazon_product_advertising_api/operations/base.rb",
     "lib/amazon_product_advertising_api/operations/browse_node.rb",
     "lib/amazon_product_advertising_api/operations/item.rb",
     "lib/amazon_product_advertising_api/response_elements.rb",
     "lib/amazon_product_advertising_api/support.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/completelynovel/amazon-product-advertising-api}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A nice rubyish interface to the Amazon Product Advertising API.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
