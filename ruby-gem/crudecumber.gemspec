Gem::Specification.new do |s|
  s.name        = 'crudecumber'
  s.version     = '0.4.0'
  s.date        = Date.today.to_s
  s.summary     = "A manual Cucumber runner"
  s.description = "Manually run through your Cucumber scenarios.\n
  Hit \'P\' to pass a step, \'F\' to fail, or \'S\' to skip! \n
  Run exactly as you would run Cucumber but instead use \'crudecumber\' followed
  by your usual Cucumber arguments."
  s.author      = ['Dan Buckland']
  s.email       = 'me@danb.io'
  s.files       = Dir['lib/**/**/*'] + Dir['bin/*']
  s.homepage    = 'http://crudecumber.xyz'
  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.3'

  s.add_runtime_dependency 'cucumber', '~> 1.3', '>= 1.3.3'

  s.executables << 'crudecumber'
end
