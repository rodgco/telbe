# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telbe/version'

Gem::Specification.new do |spec|
  spec.name          = 'telbe'
  spec.version       = Telbe::VERSION
  spec.date          = '2019-05-07'
  spec.authors       = ['Rodrigo Garcia Couto']
  spec.email         = ['r@rodg.co']
  spec.summary       = 'A Telegram Bot Engine'
  spec.description   = 'Still in development. A Telegram Bot Engine that eventually will support all of Telegrams features'
  spec.homepage      = 'https://github.com/rodgco/telbe'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_dependency 'excon', '>= 0.64.0'
  spec.add_dependency 'simplify_api', '~> 0.1'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.1'
  spec.add_development_dependency 'rubocop', '~> 0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.4'
end
