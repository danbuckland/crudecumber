require 'io/console'

module PassFail

  def pass?
    state = 'stty -g'
    begin
      system("stty raw -echo isig")
      str = STDIN.getc.chr
      case
      when str.chr == "p"
        true
      when str.chr =="\r"
        true
      when str.chr == "f"
        false
      when str.chr == "x"
        false
      else
        # something
      end
    ensure
      system("stty -raw echo")
    end
  end

end

World(PassFail)
