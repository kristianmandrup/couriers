Feature: Enter Company name
  In order to specify the company name
  As a Courier company
  I need to be able to edit the company name

  Background:
    Given I am on the Courier company general info profile page

  Scenario: Enter company name
    When I enter "valid company name"
    And click "Save"
    Then I should see "Success"
