require 'io/console'

module PassFail

  def capture_key
    str = "v"
    system("stty raw -echo isig")
    until ["p", "\r", "f", "x"].include? str do
      str = STDIN.getc.chr
    end
    str
  end

  def pass?(a)
    case
      when a == "p"
        true
      when a =="\r"
        true
      when a == "f"
        false
      when a == "x"
        false
      else
      end
    ensure
      system("stty -raw echo")
  end

end

World(PassFail)

# TODO fix bug where using ctrl+c leaves the terminal without echo and in raw
# TODO ignore key presses that are not pass or fail
