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
