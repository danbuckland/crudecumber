require 'rubygems'
require 'cucumber/formatter/pretty'
require 'cucumber/formatter/html'

module Crudecumber
  # Custom formatter that inherits from the standard Cucumber 'Pretty'
  # formatter used for terminal output.
  #
  # The formatter prints each scenario step before it is run (similar to the
  # SlowHandCuke formatter) and stops irrelevant Ruby errors being displayed.
  class Formatter < Cucumber::Formatter::Pretty
    def before_step(step)
      @io.printf "... #{step.name}"
      @io.flush
    end

    def before_step_result(*args)
      @io.printf "\r"
      super
    end

    def exception(_arg_1, _arg_2)
      # Do nothing
    end
  end

  # Custom formatter that inherits from the standard Cucumber 'Html' formatter
  # used for terminal output.
  #
  # The formatters sole purpose is to stop ruby errors being displayed in the
  # output HTML report.
  class Report < Cucumber::Formatter::Html
    def exception(_arg_1, _arg_2)
      # Do nothing
    end
  end
end
