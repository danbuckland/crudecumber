Then(/^.*$/) do
  Cucumber.trap_interrupt
  key = capture_key
  fail unless pass?(key)
end
