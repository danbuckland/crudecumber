require 'launchy'

require File.dirname(__FILE__) + '/pass_fail.rb'
require File.dirname(__FILE__) + '/crudecumber_formatter.rb'

# Automatically opens the HTML report unless Crudecumber is terminated early.
at_exit do
  d = Dir.pwd
  unless Cucumber.wants_to_quit
    Launchy.open('file:///' + d + '/crudecumber_results.html')
  end
end
