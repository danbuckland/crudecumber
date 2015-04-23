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
      exit!(1) if Cucumber.wants_to_quit
      Cucumber.wants_to_quit = true
      system("stty -raw echo")
      STDERR.puts "\nPress 'Ctrl + c' again to quit Crudecumber"
    end
  end

end

World(PassFail)
