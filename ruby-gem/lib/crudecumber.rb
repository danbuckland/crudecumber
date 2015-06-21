# This simply requires the Crudecumber step definitions and runs Cucumber with
# a SlowHandCuke style formatter and an output HTML report.

trap('INT') do
  system('stty -raw echo')
  STDERR.puts "\n\n"
  exit!(1)
end

def log(message)
  return unless ARGV.include?('-v' || '--verbose')
  $stdout.puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} - #{message}"
end

def steps
  File.join(File.dirname(File.expand_path(__FILE__)),
            'crudecumber/crudecumber_steps.rb')
end

def support_files
  File.join(File.dirname(File.expand_path(__FILE__)),
            'crudecumber/support/')
end

STDOUT.sync = true
arguments = ARGV
cmd = "cucumber #{arguments.join(' ')} -x -e features/step_definitions "\
      "-r #{steps} -r #{support_files} "\
      '-f Crudecumber::Formatter -f Crudecumber::Report '\
      '-o crudecumber_results.html'
log cmd
exit_code = system(cmd)

sleep(1)
exit_code
