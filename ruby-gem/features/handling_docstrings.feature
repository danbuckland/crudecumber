@docstrings
Feature: Handling scenarios with Doc Strings

  Similar to Tables, Doc Strings are a type of Multiline argument that can be
  used to show largers pieces of text or code in a scenario step.

  Previously Crudecumber would crash when DocStrings were used, but now they are
  handled well enough to be workable.

Scenario: Display and overwrite Doc Strings
  Given I have scenario that contains a Doc String like:
    """
    What are Doc Strings?
    =====================
    Doc Strings are handy for passing a larger piece of text to a step
    definition. The syntax is inspired from Python's Docstring syntax.

    The text should be offset by delimiters consisting of three double-quote
    marks on lines of their own.
    """
  When I run 'crudecumber'
  Then I should be able to step through this scenario manually
