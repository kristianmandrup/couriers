Feature: Enter main contact
  In order to specify the main contact
  As a Courier company
  I need to be able to edit the main contact

  Background:
    Given I am on the Courier company general info profile page

  Scenario: Enter valid contact info
    When I enter "valid contact info"
    And click "Save"
    Then I should see "Success"

  Scenario: Enter invalid contact info
    When I enter "invalid contact info"
    And click "Save"
    Then I should see "Contact info is invalid"
