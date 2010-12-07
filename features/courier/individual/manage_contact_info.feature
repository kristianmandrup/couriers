Feature: Manage Courier contact info
  In order to manage my contact info
  As a Courier
  I need to be able to edit contact info

  Background:
    Given I am on the general info profile page
      
  Scenario: Valid contact info   
    When I enter "valid contact info "
    Then I should see "Success"

  Scenario: Invalid contact info   
    When I enter valid "invalid contact info"
    Then I should see "Failure"
