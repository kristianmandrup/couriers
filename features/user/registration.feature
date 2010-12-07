Feature: Courier registration
  In order to sign up for an account
  As a Courier
  I need to be able to register

  Background:
    Given I am on the Courier registration page

  Scenario: Registration - username taken
    When I fill in valid "email" and "passwords"
    And I enter a username already taken
    Then I should see "The username is already taken"


  Scenario Outline: Enter invalid username displays inline errors
    When I fill in valid "email" and "passwords"
    When I fill in "username" with "<value>"
    And I press "Sign up"
    Then I should see the inline error "<error>" for "username"

    Examples:
      | field    	| value   | error                    	|
      | username 	|       	| Can't be blank        	  |
      | username 	| a     	| The username is not valid |
      | username 	| abc#    | The username is not valid |

  Scenario Outline: Enter invalid email displays inline errors
    When I fill in "email" with "<value>"
    And I press "Sign up"
    Then I should see the inline error "<error>" for "<field>"

    Examples:
      | value 	  | error                   	|
      |       	 	| The email can't be blank  |
      | a@b      	| The email is not valid 		|
      | a@b.blip 	| The email is not valid 		|

  Scenario Outline: Enter invalid password combination displays inline errors
    When I fill in valid "username" and "email"
    And I fill in "password" with "<password>"
    And I fill in "confirmation" with "<confirmation>"
    And I press "Sign up"
    Then I should see the inline error "<error>"

    Examples:
      | password 	| confirmation 	| error 						                        |
      |          	| abc12345     	| The password can't be blank 			        |
      | abc1234  	|              	| The confirmation password can't be blank 	|

  Scenario Outline: Registration - password confirmation error
    When I fill in valid "username" and "email"
    And I fill in "password" with "<password>"
    And I fill in "password confirmation" with "<confirmation>"
    Then I should see "You password and confirmation do not match"

    Examples:
      | password | confirmation 	|
      | abc1234   | Abc1234      	|
      | abc1234   | abc12345     	|
