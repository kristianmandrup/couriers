Feature: Modify name
  In order to modify my name
  As a registered customer
  I need to be able to access and edit my main profile data

  Background:
    Given a logged in operator
    And I am on the main profile page    

  Scenario Outline: Modifying names with invalid data displays inline errors
    When I fill in "first_name" with "<first_name>"
    And I fill in "last_name" with "<last_name>"
    And I press "Save"
    Then I should see "<action>"

    Examples:
      | first_name | last_name  |             action                |
      |            | blip 	    | see "First name can't be blank" 	|
      | blip		   |        	  | see "Last name can't be blank"    |
      | b 		     | a 	        | see "First name is too short"   	|

  Scenario Outline: Modifying address with valid data displays success
    When I fill in "first_name" with "<first_name>"
    And I fill in "last_name" with "<last_name>"
    And I press "Save"
    Then I should see "<action>"

    Examples:
      | first_name | last_name |   action       |
      | blap       | blip 	   |  Success" 	    |
