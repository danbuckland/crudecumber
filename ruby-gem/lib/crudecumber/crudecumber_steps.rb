# Global step definition which matches with all steps in a feature.
# Essentially listens for the keys "return", "p", "f", "x" and "s" and then
# decides whether to pass, fail or skip the step being run.

Then(/^.*$/) do | *x |
  Cucumber.trap_interrupt
  key = capture_key
  if skipped?(key)
    puts "  Test skipped\033[K"
    pending
  else
    unless pass?(key)
      print "\n    Describe the problem: "
      puts "  Notes: #{STDIN.gets.chomp}\033[K"
      fail
    end
  end
end
