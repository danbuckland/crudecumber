@docstrings
Feature: Handling scenarios with Doc Strings

  Similar to Tables, Doc Strings are a type of Multiline argument that can be
  used to show largers pieces of text or code in a scenario step.

  Previously Crudecumber would crash when DocStrings were used, but now they are
  handled well enough to be workable.

Scenario: Display and overwrite Doc Strings
  Given I have a scenario that contains a Doc String like:
    """
    What are Doc Strings?
    =====================
    Doc Strings are handy for passing a larger piece of text to a step
    definition. The syntax is inspired from Python's Docstring syntax.
    """
  When I run 'crudecumber'
  Then I should be able to step through this scenario manually

Scenario: Skip Doc String step
  Given I have a scenario that contains a Doc String
  When I skip this step and it is marked as Pending by Crudecumber
  Then this should be skipped and the following should appear correctly:
    """ruby
    STDOUT.sync = true
    arguments = ARGV
    cmd = "cucumber #{arguments.join(' ')} -x -e features/step_definitions "\
          "-r #{steps} -r #{support_files} "\
          '-f Crudecumber::Formatter -f Crudecumber::Report '\
          '-o crudecumber_results.html'
    log cmd
    exit_code = system(cmd)
    """

Scenario: Mark Doc String step as Pending
  Given I have a scenario that contains a Doc String
  When I press 's' to mark this Doc String step as Pending:
    """ruby
    STDOUT.sync = true
    arguments = ARGV
    cmd = "cucumber #{arguments.join(' ')} -x -e features/step_definitions "\
          "-r #{steps} -r #{support_files} "\
          '-f Crudecumber::Formatter -f Crudecumber::Report '\
          '-o crudecumber_results.html'
    log cmd
    exit_code = system(cmd)
    """
  Then this step should be shown as skipped and everything appear correctly

Scenario: Fail Doc String step
  Given I have a scenario that contains a Doc String
  When I fail the step containing this Doc String:
    """
    What are Doc Strings?
    =====================
    Doc Strings are handy for passing a larger piece of text to a step
    definition. The syntax is inspired from Python's Docstring syntax.
    """
  Then this step should be shown as skipped and everything appear correctly
