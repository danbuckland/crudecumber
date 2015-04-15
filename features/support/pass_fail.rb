require 'io/console'

module PassFail

  def pass?
    begin
      system("stty raw -echo -icanon isig")
      str = STDIN.getc.chr
      if str.chr == "p"
        true
      elsif str.chr =="\r"
        true
      elsif str.chr == "f"
        false
      elsif str.chr == "x"
        false
      else
        # Need this to return to the start if any other key
      end
    ensure
      system("stty -raw echo icanon")
    end
  end

end

World(PassFail)
