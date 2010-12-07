Feature: Log in
  In order to use the site
  As a registered user
  I need to be able to login

  Background:
    Given that a confirmed user exists
    And the user is not logged in

  Scenario Outline: Logging in with email
    Given I am on the login page
    When I fill in "user_email" with "<email>"
    And I fill in "user_password" with "<password>"
    And I press "Sign in"
    Then I should "<action>"
    Examples:
      |         email       	|  password   	|              action          	   	|
      | minimal@example.com 	|  test1234     | see "Signed in successfully"    	|
      | bad@example.com     	|  password   	| see "Invalid email or password" 	|

  Scenario Outline: Logging in with username
    Given I am on the login page
    When I fill in "username" with "<username>"
    And I fill in "password" with "<password>"
    And I press "Sign in"
    Then I should see "<action>"
    Examples:
      |   username   	|  password 	|              action    	        |
      | gooduser		  |  test1234   | "Signed in successfully"        |
      | baduser   	 	|  password   | "Invalid username or password"	|
