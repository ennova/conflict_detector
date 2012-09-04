# -*- encoding: utf-8 -*-
require File.expand_path('../lib/conflict_detector/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Tate Johnson', 'Odin Dutton', 'Jason Weathered']
  gem.email         = ['tate@tatey.com', 'odindutton@gmail.com', 'jason@jasoncodes.com']
  gem.summary       = %q{ConflictDetector is a convenience class for saving the record, or returning the conflict.}
  gem.description   = gem.summary
  gem.homepage      = 'https://github.com/ennova/conflict_detector'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.name          = 'conflict_detector'
  gem.require_paths = ['lib']
  gem.version       = ConflictDetector::VERSION
end
