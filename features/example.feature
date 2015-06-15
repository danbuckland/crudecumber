Feature: Use Cucumber as a manual test tool

  As a QA Engineer learning Cucumber, I want to write scenarios for a product
  and run them manually.

  Scenario: Pass steps
    Given my directory contains a features folder with at least 1 feature file
    When I type "crudecumber" in the Terminal to run Crudecumber
    And I press "p" or "enter" on the keyboard
    Then the step should pass

  Scenario: Fail steps
    Given my directory contains a features folder with at least 1 feature file
    When I type "crudecumber" in the Terminal to run Crudecumber
    And I press "f" or "x" on the keyboard
    Then the step should fail
    And I should be able to provide a reason for the failure

  Scenario: Skip steps
    Given my directory contains a features folder with at least 1 feature file
    When I type "crudecumber" in the Terminal to run Crudecumber
    And I press "s" on the keyboard
    Then the step should be skipped

  Scenario: Exit Crudecumber
    Given my directory contains a features folder with at least 1 feature file
    When I type "crudecumber" in the Terminal to run Crudecumber
    And I press "ctrl+c" on the keyboard
    Then Crudecumber should exit immediately
