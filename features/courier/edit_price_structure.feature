Feature: Edit Courier Pricing data
  In order to modify my Pricing data  
  As a Courier
  I need to be able to edit the Business Info on my profile

  Background:
    Given I am on the business info profile page
    And I have accepted terms and agreements
      
  Scenario: Set valid base price
    When I enter a "valid base price"
    And I click “save”
    Then I should see "Success"

  Scenario: Set valid extra kilometer price
    When I enter a "valid extra kilometer price"
    And I click “save”
    Then I should see "Success"

  Scenario: Set point where extra kilometer price kicks in
    When I enter a "valid kilometer price point"
    And I click “save”
    Then I should see "Success"

  Scenario: Set express delivery surcharge
    When I enter a "valid express delivery surcharge"
    And I click “save”
    Then I should see "Success"

  Scenario: Set relaxed delivery rebate
    When I enter a "valid relaxed delivery rebate"
    And I click “save”
    Then I should see "Success"

  Scenario: Set night delivery surcharge
    When I enter a "valid night delivery surcharge"
    And I click “save”
    Then I should see "Success"
