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
