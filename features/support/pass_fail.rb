require 'io/console'

module PassFail

  def pass?
    begin
      system("stty raw -echo -icanon isig")
      str = STDIN.getc.chr
      if str.chr == "p"
        true
      else
        false
      end
    ensure
      system("stty -raw echo icanon")
    end
  end

end

World(PassFail)
