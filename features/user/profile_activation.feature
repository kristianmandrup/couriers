Feature: Profile Activation
  In order to activate my Profile account
  As a courier
  I want to be able to confirm activation

  Background:
    Given I am pending confirmation

  Scenario: Confirmation
    Given I received the email
    When I confirm the account
    Then I should find that I am confirmed
