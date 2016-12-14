Feature: Running any Cucumber scenarios with the Crudecumber gem

  As a QA Engineer learning Cucumber, I want to write scenarios for a product
  and run them manually.

  Scenario: Run external feature file with Crudecumber
    Given I have a feature file in a features directory
    And I have the Crudecumber gem installed
    When I run 'crudecumber'
    Then I should be able to step through my scenarios manually

  @bugs @2
  Scenario: Ignore local step definitions to avoid ambiguous matches
    Given I have local step definitions for this step
    And a default profile explicitly requiring the step_definitions folder
    When I run 'crudecumber --v'
    Then the local step definition should not be loaded
    And I should be able to step through my scenarios manually

  @tables
  Scenario: Allow testers to manually run scenarios with tables
    Given I have a scenario that contains the following table:
    | Javan Slow Loris    |
    | Rondo Dwarf Galago  |
    | Brown Spider Monkey |
    When I run 'crudecumber'
    Then I should be able to step through this scenario manually

  @tables
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
