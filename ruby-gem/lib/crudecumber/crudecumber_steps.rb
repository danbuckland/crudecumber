Then(/^.*$/) do
  Cucumber.trap_interrupt
  key = capture_key
  unless skipped?(key)
    unless pass?(key)
      print "\n    Describe the problem: "
      puts "  Notes: " + STDIN.gets.chomp
      fail
    end
  else
    puts "  Test skipped"
    pending
  end
end
