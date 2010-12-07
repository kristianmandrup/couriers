Feature: Select payment method
  In order to select my payment method
  As a registered customer
  
Background:
   I am on the payment page

Scenario: Paypal
    When I select "<payment method>" for "payment method"
    And I press "Continue"
    Then I should see "Success"

  Scenario Outline: Select basic payment method
    When I select "<payment method>" for "payment method"
    And I press "Continue"
    Then I should see "<action>"

    Examples:
      | payment method   |             action          |
      | creditcard         | "Credit card Account number" |
      | bank transfer    | "Bank Account number" |
