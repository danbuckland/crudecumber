require 'crudecumber/translator'
require 'crudecumber/project_generator'
require 'optparse'

def log(message)
  $stdout.puts "#{Time.now.strftime("%Y-%m-%d %H:%M:%S")} - #{message}" if (ARGV.include? "-v" or ARGV.include? "--verbose")
end

STDOUT.sync = true
arguments = ARGV
cmd = "cucumber #{arguments.join(" ")}"
log cmd
exit_code = system(cmd)

sleep(1)
exit_code

# Most of this can be ignored, it's work in progress - just playing with
# passing options through the command line.

  # options = {language: nil, project: nil}
  #
  # parser = OptionParser.new do |opts|
  # 	opts.banner = ["Usage: crudecumber [options]", "",
  #             "Examples:",
  #             "crudecumber",
  #             "crudecumber -l spanish",
  #             "crudecumber -p new-project", "", "",
  #             ].join("\n")
  #
  # 	opts.on('-l', '--language LANGUAGE', 'Language') do |language|
  # 		options[:language] = language
  # 	end
  #
  #   opts.on('-p', '--project PROJECT', 'Creates a new project folder') do |project|
  #     options[:project] = project
  # 	end
  #
  # 	opts.on('-h', '--help', 'Displays Help') do
  # 		puts opts
  # 		exit
  # 	end
  # end
  #
  # parser.parse!
