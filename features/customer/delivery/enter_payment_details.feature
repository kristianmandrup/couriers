Feature: Enter payment bank account details
  In order to pay for delivery  
  As a registered customer
  I should be able to enter my payment bank account details

  Scenario Outline: Entering invalid bank payment data displays inline errors
    When I fill in "owner" with "<owner>"
    And I fill in "bank name" with "<bank name>"
    And I fill in "account number" with "<account number>"
    And I fill in "blz" with "<blz>"
    And I press "Save"
    Then I should "<action>"

    Examples:
      | owner  |  bank name  | account number |             action          |
      |        |  the bank   | 2342324233     | see "Owner can't be blank" |
      | jones  |             | 2342324233     | see "Bank name can't be blank"    |
      | jones  |  the bank   |                | see "Account number can't be blank"   |    

  Scenario: Entering valid bank payment data displays success
    When I fill in "owner" with "<owner>"
    And I fill in "bank name" with "<bank name>"
    And I fill in "account number" with "<account number>"
    And I fill in "blz" with "<blz>"
    Then I should see "Your delivery has been paid"
