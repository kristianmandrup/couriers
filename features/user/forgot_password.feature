Feature: Forgot password
  In order to login
  As a registered user
  When I have forgotten my password
  I should be able to reset it

  Background:
    Given that a confirmed user exists

  Scenario Outline: Reset password request
    Given I am on the forgotten password page
    When I fill in "user_email" with "<email>"
    And I press "Send me reset password instructions"
    Then I should see "<action>"
    Examples:
      |         email      		|             message                           |
      | minimal@example.com 	| You will receive an email with instructions 	|
      | bad@example.com     	| Email not found                               |

  Scenario: Reset password confirmation
    Given that I have reset my password
    When I follow the reset password link in my email
    Then I expect to be able to reset my password
