@examples
Feature: Handling scenario outlines with examples

  In Cucumber, users can create a Scenario Outline with a table of examples that
  are used in each step. This essentially combines multiple scenarios into one.

  Running this with Crudecumber, individual scenarios need to be displayed for
  each row in the table.

  Scenario Outline: Allow testers to manually run scenario outlines
    Given I have a table full of examples
    And <country> has <tourists> visitors each year
    And an area of <area>
    When I run 'crudecumber'
    Then I should be able to step through each scenario manually

    Examples:
      | country      | area     | tourists  |
      | Vatican City | 0.44km^2 | 4,300,000 |
      | Monaco       | 1.95km^2 | 328,000   |
      | San Marino   | 61km^2   | 70,000    |
