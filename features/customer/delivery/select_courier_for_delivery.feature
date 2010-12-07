Feature: Select courier for delivery
  In order to select my courier for delivery of package
  As a registered customer
  I must select a courier bid from a list of courier bids 
  
Background:
   I am on the courier bids page

Scenario: No bids made
   Then I should see no bids

Scenario: One bid made
   Then I should see one bid
   When I select the first bid
   And I press "Accept"
   Then I should see "Bid was accepted"

  Scenario Outline: Select bid from multiple bids
    Then I should see multiple bid
    When I select "<bid>"    
    And I press "Accept"
    Then I should see "Bid <bid> was accepted for € <price>"

    Examples:
      | courier |  bid | price  |
      | mike    | 1    |   10   |
      | sally   | 3    |   20   |
