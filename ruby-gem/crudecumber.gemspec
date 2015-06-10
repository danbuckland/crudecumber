Gem::Specification.new do |s|
  s.name        = 'crudecumber'
  s.version     = '0.1.1'
  s.date        = '2015-06-09'
  s.summary     = "Crudecumber 0.1.1"
  s.description = "Manually run through your Cucumber scenarios.\n
  Run exactly as you would run Cucumber but instead use \"crudecumber\" followed
  by your usual arguments.\n\nThis is an early release and there are some known
  bugs:\n\n- Currently doesn't work with Cucumber tables\n- May not work if you
  use profiles to manually require automation step definitions\n- Using ctrl + c
   to cancel is a bit messy at the moment."
  s.author      = ['Dan Buckland']
  s.email       = 'danbucklan@gmail.com'
  s.files       = Dir['lib/**/**/*'] + Dir['bin/*']
  s.homepage    = 'http://rubygems.org/gems/crudecumber'
  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency 'cucumber', '1.3.19'
  s.add_dependency 'slowhandcuke', '0.0.3'
  s.add_dependency 'launchy', '2.4.3'

  s.executables << 'crudecumber'
end
