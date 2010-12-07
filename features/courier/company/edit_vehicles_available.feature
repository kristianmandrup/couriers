Feature: Enter Vehicles available
  In order to specify vehicles available
  As a Courier company
  I need to be able to enter number of vehicles for each type of vehicle

  Background:
    Given I am on the Courier company business info profile page
    And I have accepted terms and conditions

  Scenario: Enter valid vehicle count   
    When I enter "valid vehicle data"
    And click "Save"
    Then I should see "Success"

  Scenario: Enter invalid vehicle count   
    When I enter "invalid vehicle data"
    And click "Save"
    Then I should see "Failure"
