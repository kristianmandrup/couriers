Feature: Create delivery order
  In order to create a delivery order
  As a registered customer
  I must select a pick-up and destination point and any other delivery data
  
Background:
   I am on the create delivery order page

Scenario: Create valid delivery order
   Then I should see one bid
   When I select the first bid
   And I press "Accept"
   Then I should see "Route is valid"
  And I press "continue"
   Then I should go to the courier bids page

  Scenario Outline: Create invalid delivery order
    When I select "<pick_up>"    
    And I select "<destination>”
    Then I should see "The delivery route selected is not valid"
    Examples:
      | pick_up          |  destination | 
      | mitte            |  mitte       |   
      | isle             | mitte        |  
