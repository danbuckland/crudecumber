# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'crudecumber'
  s.version     = '0.5.0'
  s.date        = Date.today.to_s
  s.summary     = 'A manual Gherkin scenario runner'
  s.description = "Manually step through your Gherkin scenarios.\n\n" \
                  "Hit 'P' to pass a step, 'F' to fail, or 'S' to skip!\n" \
                  'Run against any directory of .feature files, independent of any test framework.'
  s.author      = ['Dan Buckland']
  s.email       = 'me@danb.io'
  s.files       = Dir['lib/**/*'] + Dir['bin/*']
  s.homepage    = 'http://crudecumber.xyz'
  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 3.2'

  s.executables << 'crudecumber'
end
