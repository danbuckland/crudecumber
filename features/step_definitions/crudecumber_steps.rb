Then(/^.*$/) do
  Cucumber.trap_interrupt
  key = capture_key
  unless pass?(key)
    print "\nDescribe the problem:\n"
    puts "Notes: " + STDIN.gets.chomp
    fail
  end
end
