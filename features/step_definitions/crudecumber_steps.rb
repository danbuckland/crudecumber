Then(/^.*$/) do
  key = capture_key
  fail unless pass?(key)
end
