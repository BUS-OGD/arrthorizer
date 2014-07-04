# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arrthorizer/version'

Gem::Specification.new do |gem|
  gem.name          = "arrthorizer"
  gem.version       = Arrthorizer::VERSION
  gem.authors       = ["René van den Berg", "Lennaert Meijvogel"]
  gem.email         = ["rene.vandenberg@ogd.nl", "lennaert.meijvogel@ogd.nl"]
  gem.description   = %q{Contextual authorization for your Rails (3+) application}
  gem.summary       = %q{Contextual authorization for your Rails (3+) application}
  gem.homepage      = "https://github.com/BUS-ogd/arrthorizer"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency             'rails', '>= 3.2.18'
  gem.add_development_dependency 'combustion', '~> 0.5.1'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'rspec-rails', '>= 3'
end
