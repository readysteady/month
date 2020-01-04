Gem::Specification.new do |s|
  s.name = 'month'
  s.version = '1.5.0'
  s.license = 'MIT'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'https://github.com/timcraft/month'
  s.description = 'A little Ruby library for working with months'
  s.summary = 'See description'
  s.files = Dir.glob('{lib,spec}/**/*') + %w(LICENSE.txt README.md month.gemspec)
  s.required_ruby_version = '>= 1.9.3'
  s.require_path = 'lib'
end
