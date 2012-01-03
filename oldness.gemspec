$:.push File.expand_path("../lib", __FILE__)
require 'oldness/version'

Gem::Specification.new do |s|
  s.name = 'oldness'
  s.version = Oldness::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = '2011-12-20'
  s.authors = ['Nick Novitski']
  s.email = 'nicknovitski@gmail.com'
  s.homepage = 'http://github.com/njay/oldness'
  s.summary = 'Instant historical perspective'
  s.description = 'A library and shell command that rates the age of different types of things on a five-star system'

  s.required_rubygems_version = '>= 1.3.7'
  s.specification_version = 3

  ignores = File.readlines(".gitignore").grep(/\S+/).map {|s| s.chomp }
  dotfiles = [".gitignore"]

  s.files = Dir["**/*"].reject {|f| File.directory?(f) || ignores.any? {|i| File.fnmatch(i, f) } } + dotfiles
  s.test_files = s.files.grep(/^spec\//)
  s.require_paths = ['lib']
  s.executables = ['oldness']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'bundler'
  s.add_dependency 'thor', '~> 0.14'
end