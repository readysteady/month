Gem::Specification.new do |s|
  s.name = 'month'
  s.version = '1.7.0'
  s.license = 'MIT'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'https://github.com/readysteady/month'
  s.description = 'Ruby gem for working with months'
  s.summary = 'See description'
  s.files = Dir.glob('lib/**/*.rb') + %w(LICENSE.txt README.md month.gemspec)
  s.required_ruby_version = '>= 1.9.3'
  s.require_path = 'lib'
  s.metadata = {
    'homepage' => 'https://github.com/readysteady/month',
    'source_code_uri' => 'https://github.com/readysteady/month',
    'bug_tracker_uri' => 'https://github.com/readysteady/month/issues',
    'changelog_uri' => 'https://github.com/readysteady/month/blob/master/CHANGES.md'
  }
end
