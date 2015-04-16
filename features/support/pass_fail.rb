require 'io/console'

module PassFail

  def capture_key
    str = ""
    system("stty raw -echo isig")
    until ["p", "\r", "f", "x"].include? str.downcase do
      str = STDIN.getc.chr
    end
    system("stty -raw echo")
    str.downcase
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
      STDERR.puts "\nPress 'Ctrl + C' again to end your test run"
    end
  end

end

World(PassFail)
