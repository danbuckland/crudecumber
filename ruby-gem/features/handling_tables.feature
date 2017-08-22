@tables
Feature: Handling scenarios with tables

  With the SlowHandCuke formatter, upon which the Crudecumber formatter is
  based, tables that are part of steps do not render until after the step has
  been passed or failed. This makes running the tests manually impossible!

  The Crudecumber formatter has since been updated to handle these multiline
  arguments correctly and display them before the result of the step.

  Scenario: Allow testers to manually run scenarios with tables
    Given I have a scenario that contains the following table:
    | Javan Slow Loris    |
    | Rondo Dwarf Galago  |
    | Brown Spider Monkey |
    When I run 'crudecumber'
    Then I should be able to step through this scenario manually

  Scenario: Display and overwrite long tables
    Given I have a scenario that contains the following table:
    | Most Endangered Species     | Number left |
    | Ivory-Billed Woodpecker     | A handful   |
    | Amur Leopard                | 20          |
    | Javan Rhinoceros            | 40-60       |
    | Lemur                       | ?           |
    | Northern Right Whale        | 350         |
    | Vaquita                     | 500-600     |
    | Black Rhinoceros            | 5000+       |
    | Mountain Gorilla            | 302-408     |
    | Baiji/Yangtze River Dolphin | 3+          |
    | Saola/Asian Unicorn         | ?           |
    When I run 'crudecumber'
    Then I should be able to step through this scenario manually

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
