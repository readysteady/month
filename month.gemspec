Gem::Specification.new do |s|
  s.name = 'month'
  s.version = '2.0.0'
  s.license = 'MIT'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['email@timcraft.com']
  s.homepage = 'https://github.com/readysteady/month'
  s.description = 'Ruby gem for working with months'
  s.summary = 'See description'
  s.files = Dir.glob('lib/**/*.rb') + %w[CHANGES.md LICENSE.txt README.md month.gemspec]
  s.required_ruby_version = '>= 2.6.0'
  s.require_path = 'lib'
  s.metadata = {
    'homepage' => 'https://github.com/readysteady/month',
    'source_code_uri' => 'https://github.com/readysteady/month',
    'bug_tracker_uri' => 'https://github.com/readysteady/month/issues',
    'changelog_uri' => 'https://github.com/readysteady/month/blob/main/CHANGES.md'
  }
end
