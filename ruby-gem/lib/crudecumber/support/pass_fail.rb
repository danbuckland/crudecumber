require 'io/console'

module PassFail

  def capture_key
    str = ""
    system("stty raw -echo isig")
    until ["p", "\r", "f", "x", "s"].include? str.downcase do
      str = STDIN.getc.chr
    end
    system("stty -raw echo")
    str.downcase
  end

  def skipped?(a)
    {
      s: true,
      p: false,
      :"\r" => false,
      x: false,
      f: false
    }[a.to_sym]
  end

  def pass?(a)
      {
        p: true,
        :"\r" => true,
        x: false,
        f: false
      }[a.to_sym]
  end

  def Cucumber.trap_interrupt
     trap('INT') do
       exit!(1)
     end
  end

end

World(PassFail)
