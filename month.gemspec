Gem::Specification.new do |s|
  s.name = 'month'
  s.version = '1.1.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'http://github.com/timcraft/month'
  s.description = 'A little library for working with months'
  s.summary = 'See description'
  s.files = Dir.glob('{lib,spec}/**/*') + %w(README.md month.gemspec)
  s.required_ruby_version = '>= 1.9.3'
  s.add_development_dependency('rake', '~> 10.0')
  s.add_development_dependency('minitest', '~> 5.0')
  s.require_path = 'lib'
end
