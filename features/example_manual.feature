@manual

Feature: Manually check gmail

  As a QA Engineer learning Cucumber, I want to write scenarios for a product
  and run them manually.

  Scenario: Log in and check email
    Given I navigate to mail.google.com
    When I submit valid login credentials
    Then I should see my emails in the Inbox view

  Scenario: Read all unread emails
    Given I am logged in
    And I have unread emails in my account
    When I select "Mark all as read"
    Then I should have no unread emails in my account
