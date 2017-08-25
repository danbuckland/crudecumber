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
    Given I have a scenario that contains the following longer table:
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

  Scenario: Fail step containing a table
    Given I have a scenario that contains a table
    When I fail the step containing this table:
      | Gross monthly income:             | £2,208.33 |
      | Personal allowance:               |   £883.33 |
      | Total tax deductions:             |   £265.00 |
      | National Insurance contributions: |   £184.40 |
      | Total deductions:                 |   £449.40 |
      | Net monthly income:               | £1,758.93 |
    Then this step should be shown as skipped and everything appear correctly

  Scenario: Mark step containing a table as Pending
    Given I have a scenario that contains a table
    When I press 's' to mark this table step as pending:
      | Gross monthly income:             | £2,208.33 |
      | Personal allowance:               |   £883.33 |
      | Total tax deductions:             |   £265.00 |
      | National Insurance contributions: |   £184.40 |
      | Total deductions:                 |   £449.40 |
      | Net monthly income:               | £1,758.93 |
    Then this step should be shown as skipped and everything appear correctly

  @bugs @14
  Scenario: Render skipped tables only once
    Given a scenario with a table
    When I skip this step and it is marked as Pending by Crudecumber
    Then this should be skipped and the following table should appear only once
      | Gross monthly income:             | £2,208.33 |
      | Personal allowance:               |   £883.33 |
      | Total tax deductions:             |   £265.00 |
      | National Insurance contributions: |   £184.40 |
      | Total deductions:                 |   £449.40 |
      | Net monthly income:               | £1,758.93 |
