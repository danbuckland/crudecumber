# This is very much a work in progress - this is a first stab at creating a
# manual Cucumber runner.
#
# Just type "crudecumber" in any folder containing a features folder!
#

trap('INT') do
  system("stty -raw echo")
  STDERR.puts "\n\n"
  exit!(1)
end

def log(message)
  $stdout.puts "#{Time.now.strftime("%Y-%m-%d %H:%M:%S")} - #{message}" if (ARGV.include? "-v" or ARGV.include? "--verbose")
end

def steps
  File.join(File.dirname(File.expand_path(__FILE__)), 'crudecumber/crudecumber_steps.rb')
end

def support_files
  File.join(File.dirname(File.expand_path(__FILE__)), 'crudecumber/support/')
end

STDOUT.sync = true
arguments = ARGV
cmd = "cucumber #{arguments.join(" ")} -r #{steps} -r #{support_files} -f Crudecumber::Formatter -f Crudecumber::Report -o crudecumber_results.html"
log cmd
exit_code = system(cmd)

sleep(1)
exit_code
