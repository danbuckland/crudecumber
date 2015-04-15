require 'launchy'

require File.dirname(__FILE__) + '/pass_fail.rb'

at_exit do
  d = Dir.pwd
  Launchy.open("file:///" + d + "/crudecumber_results.html")
end
