Then(/^.*$/) do
  answer = STDIN.gets.chomp
  if answer == ""
  else
    print "Describe the problem:\n"
    puts "NOTES: " + STDIN.gets.chomp
    fail
  end
end
