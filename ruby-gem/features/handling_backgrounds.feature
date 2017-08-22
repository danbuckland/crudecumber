@backgrounds
Feature: Running any scenarios with backgrounds using the Crudecumber gem

  Running version 0.1.5 of Crudecumber with scenarios that have background steps
  can cause the background step to remain visible when the first scenario step
  is run. This only happens when the last background step is longer than the
  first scenario step.

  Background: Precede scenario with long background step
    Given I have a rather verbose and therefore lengthy first background step
    And I have a long second step that's not quite as long as the first one

  @bugs @7
  Scenario: Scenario steps should not overlap last background step
    When I start a scenario with a short step
    Then I should not see the background step behind

  @bugs @7
  Scenario: Scenario steps should not overlap last background step
    When I start a different scenario
    And that scenario also has a short first step
    Then I should not see the background step behind
