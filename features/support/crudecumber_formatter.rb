require 'rubygems'
require 'cucumber/formatter/pretty'
require 'cucumber/formatter/html'

module Crudecumber
  class Formatter < Cucumber::Formatter::Pretty

    def before_step( step )
      @io.printf "... #{step.name}"
      @io.flush
    end

    def before_step_result( *args )
      @io.printf "\r"
      super
    end

    def exception( arg_1 , arg_2 )
      # Do nothing
    end

  end

  class Report < Cucumber::Formatter::Html

    def exception( arg_1 , arg_2 )
      # Do nothing
    end

  end
end
