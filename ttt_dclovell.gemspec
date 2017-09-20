require File.expand_path("../lib/ttt_dclovell", __FILE__)

Gem::Specification.new do |s|
  s.name = 'ttt_dclovell'
  s.version = TttDclovell::VERSION
  s.date = '2017-09-22'
  s.summary = 'Tic Tac Toe'
  s.authors = ['Douglas Lovell']
  s.email = 'doug@wbreeze.com'
  s.files = Dir["{lib}/**/*.rb", 'LICENSE', "*.md"]
  s.require_path = 'lib'
  s.homepage = 'https://gitlab.com/dclovell/ttt'
  s.license = 'Nonstandard'
end
