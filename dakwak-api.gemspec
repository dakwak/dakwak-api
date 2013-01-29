# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dakwak-api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["dakwak"]
  gem.email         = ["nour.h@dakwak.com"]
  gem.description   = %q{dakwak is a website localization service that offers both machine and professional translation 
    in 54 different languages.You can quickly and easily translate your websites to your languages of choice, 
    and have your translated websites up and running in no time.}
  gem.summary       = %q{dakwak is a website localization service that offers both machine and professional translation 
    in 54 different languages.}
  gem.homepage      = "https://dakwak.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dakwak-api"
  gem.require_paths = ["lib"]
  gem.version       = Dakwak::Api::VERSION


  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'httparty'
  gem.add_runtime_dependency 'httparty'
  gem.add_development_dependency 'test-unit'
end
