# Global step definition which matches with all steps in a feature.
# Essentially listens for the keys "return", "p", "f", "x" and "s" and then
# decides whether to pass, fail or skip the step being run.

Then(/^.*$/) do
  Cucumber.trap_interrupt
  key = capture_key
  if skipped?(key)
    puts '  Test skipped'
    pending
  else
    unless pass?(key)
      print "\n    Describe the problem: "
      puts '  Notes: ' + STDIN.gets.chomp
      fail
    end
  end
end
