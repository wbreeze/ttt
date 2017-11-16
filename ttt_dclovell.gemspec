lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ttt_dclovell/version'

Gem::Specification.new do |s|
  s.name = 'ttt_dclovell'
  s.version = TttDclovell::VERSION
  s.summary = 'Tic Tac Toe'
  s.authors = ['Douglas Lovell']
  s.email = ['doug@wbreeze.com']
  s.files = Dir['{lib}/**/*.rb', 'LICENSE', '*.md']
  s.require_path = 'lib'
  s.homepage = 'https://github.com/wbreeze/ttt'
  s.license = 'GPL-3.0'
  s.bindir = 'bin'
  s.executables = 'ttt'

  # app dependencies
  s.add_runtime_dependency 'finite_machine', '~> 0.11.0'

  # dev dependencies
  s.add_development_dependency 'bundler', '~> 1.16.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'simplecov', '~> 0.15.0'

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = ''
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end
end
