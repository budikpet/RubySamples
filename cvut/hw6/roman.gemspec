# frozen_string_literal: true

require File.expand_path('lib/roman/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'roman'
  s.version     = Roman::VERSION
  # s.homepage    = '{origin-repo-uri}'
  s.license     = 'MIT'
  s.author      = 'Petr Budík'
  s.email       = 'budikpet@fit.cvut.cz'

  s.summary     = 'Allows transformations between Arabic and Roman numbers.'

  s.files       = Dir['bin/*', 'lib/**/*', '*.gemspec', 'LICENSE*', 'README*']
  s.executables = Dir['bin/*'].map { |f| File.basename(f) }

  s.required_ruby_version = '>= 2.4'

  s.add_runtime_dependency 'thor', '~> 0.20.3'

  s.add_development_dependency 'minitest', '~> 5.14.2'
  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'yard', '~> 0.9'
end
