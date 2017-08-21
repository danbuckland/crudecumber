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
      @io.printf "#{step.keyword}#{step.name}".indent(@scenario_indent + 2)
      unless step.multiline_arg.nil?
        @io.printf "#{step.multiline_arg}".indent(@scenario_indent + 2)
      end
      super
    end

    def before_step_result(*args)
      unless args[2].nil?
        rows = args[2].raw.length
        @io.printf "\033[#{rows + 1}A"
      end
      @io.printf "\r\033[K"
      super
    end

    def exception(_arg_1, _arg_2)
      # Do nothing
    end

    def table_cell_value(value, status)
      return if !@table || @hide_this_step
      status ||= @status || :passed
      width = @table.col_width(@col_index)
      cell_text = escape_cell(value.to_s || '')
      padded = cell_text + (' ' * (width - cell_text.unpack('U*').length))
      prefix = cell_prefix(status)
      @io.print(' ' + format_string("#{prefix}    #{padded}", status) + ::Cucumber::Term::ANSIColor.reset(" |"))
      @io.flush
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
