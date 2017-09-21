# coding: utf-8
require File.expand_path('../lib/ttt_dclovell', __FILE__)

Gem::Specification.new do |s|
  s.name = 'ttt_dclovell'
  s.version = TttDclovell::VERSION
  s.date = '2017-09-22'
  s.summary = 'Tic Tac Toe'
  s.authors = ['Douglas Lovell']
  s.email = ['doug@wbreeze.com']
  s.files = Dir['{lib}/**/*.rb', 'LICENSE', '*.md']
  s.require_path = 'lib'
  s.homepage = 'https://gitlab.com/dclovell/ttt'
  s.license = 'Nonstandard'

  # app dependencies
  s.add_runtime_dependency 'finite_machine', '~> 0.11.0'

  # dev dependencies
  s.add_development_dependency 'bundler', '~> 1.15'
  s.add_development_dependency 'rspec', '~> 3.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata["allowed_push_host"] = ''
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end
end
