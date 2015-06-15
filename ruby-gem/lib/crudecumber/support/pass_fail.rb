require 'io/console'

# Listens for the keys "return", "p", "f", "x" and "s" and then decides whether
# to pass, fail, or skip the step being run.
module PassFail
  def capture_key
    str = ''
    system('stty raw -echo isig')
    str = STDIN.getc.chr until ['p', "\r", 'f', 'x', 's'].include? str.downcase
    system('stty -raw echo')
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
