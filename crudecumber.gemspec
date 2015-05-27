Gem::Specification.new do |s|
  s.name        = 'crudecumber'
  s.version     = '1.1.0'
  s.date        = '2015-04-27'
  s.summary     = "Crudecumber 1.1.0"
  s.description = "Manually run through your Cucumber scenarios."
  s.author      = ['Dan Buckland']
  s.email       = 'danbucklan@gmail.com'
  s.files       = ["lib/crudecumber.rb", "lib/crudecumber/translator.rb"]
  s.homepage    = 'http://rubygems.org/gems/crudecumber'
  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency 'cucumber', '1.3.19'
  s.add_dependency 'slowhandcuke', '0.0.3'
  s.add_dependency 'launchy', '2.4.3'

  s.executables << 'crudecumber'
end
