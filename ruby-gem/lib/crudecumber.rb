# frozen_string_literal: true

require_relative 'crudecumber/runner'

$stdout.sync = true

Signal.trap('INT') do
  system('stty -raw echo')
  STDERR.puts "\n"
  exit!(1)
end

Crudecumber::Runner.run(ARGV)
