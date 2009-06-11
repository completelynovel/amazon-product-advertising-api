# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{amazon-product-advertising-api}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors           = ["Jon Gilbraith"]
  s.date              = %q{2009-06-11}
  s.description       = %q{A nice rubyish interface to the Amazon Product Advertising API, formerly known as the Associates Web Service and before that the Amazon E-Commerce Service.}
  s.email             = %q{jon@completelynovel.com}
  s.files             = ["EXAMPLE.rdoc", "MIT-LICENSE", "README.rdoc", "amazon-product-advertising-api.gemspec", "lib/amazon_product_advertising_api", "lib/amazon_product_advertising_api/base.rb", "lib/amazon_product_advertising_api/operations", "lib/amazon_product_advertising_api/operations/base.rb", "lib/amazon_product_advertising_api/operations/browse_node.rb", "lib/amazon_product_advertising_api/operations/item.rb", "lib/amazon_product_advertising_api/support.rb", "lib/amazon_product_advertising_api.rb"]
  s.has_rdoc          = false
  s.homepage          = %q{http://github.com/completelynovel/amazon-product-advertising-api}
  s.rdoc_options      = ["--inline-source", "--charset=UTF-8"]
  s.require_paths     = ["lib"]
  #s.rubyforge_project = %q{grit}
  s.rubygems_version  = %q{1.3.0}
  s.summary           = %q{A nice rubyish interface to the Amazon Product Advertising API.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mime-types>, [">= 1.15"])
      s.add_runtime_dependency(%q<diff-lcs>, [">= 1.1.2"])
    else
      s.add_dependency(%q<mime-types>, [">= 1.15"])
      s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
    end
  else
    s.add_dependency(%q<mime-types>, [">= 1.15"])
    s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
  end
end