require 'launchy'

at_exit do
  d = Dir.pwd
  Launchy.open("file:///" + d + "/crudecumber_results.html")
end
