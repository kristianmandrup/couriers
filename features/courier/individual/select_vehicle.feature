Feature: Manage Delivery Vehicles
  In order to select my delivery vehicle
  As a Courier

  Background:
    Given I am on the business info profile page
    And I have accepted terms and agreements
      
  Scenario: Select bike
    When I select "bike"
    Then I should see "Bike selected"

  Scenario: Select car
    When I select "car"
    Then I should see "Car selected"

  Scenario: Select van
    When I select "van"
    Then I should see "Van selected"
