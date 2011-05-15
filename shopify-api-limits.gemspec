# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "shopify-api-limits/version"

Gem::Specification.new do |s|
  s.name        = "shopify-api-limits"
  s.version     = ShopifyAPI::Limits::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Scott"]
  s.email       = ["christocracy@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This gem adds the ability to read shopify API call limits to the ShopifyAPI gem}
  s.description = %q{This gem adds the ability to read shopify API call limits to the ShopifyAPI gem}

  s.rubyforge_project = "shopify-api-limits"
  
  s.add_dependency "shopify_api", ">= 1.2.3"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
