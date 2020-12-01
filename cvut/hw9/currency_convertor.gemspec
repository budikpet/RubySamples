# frozen_string_literal: true

require File.expand_path('lib/currency_convertor/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'currency_convertor'
  s.version     = CurrencyConvertor::VERSION
  # s.homepage    = '{origin-repo-uri}'
  s.license     = 'MIT'
  s.author      = 'Petr Budík'
  s.email       = 'budikpet@fit.cvut.cz'

  s.summary     = 'Converts between currencies, uses current prices from ČNB.'
  s.description = 'A Thor powered CLI tool for converting between currencies. Uses HTTP requests to official ČNB site to get current prices.'

  s.files       = Dir['bin/*', 'lib/**/*', '*.gemspec', 'LICENSE*', 'README*']
  s.executables = Dir['bin/*'].map { |f| File.basename(f) }

  s.required_ruby_version = '>= 2.4'

  s.add_runtime_dependency 'thor', '~> 1.0.1'

  s.add_development_dependency 'bundler', '>= 1.0', '< 3'
  s.add_development_dependency 'rspec', '~> 3.10.0'
  s.add_development_dependency 'yard', '~> 0.9.25'
end
