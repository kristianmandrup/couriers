Feature: Log out
  In order to leave the site
  As a registered user
  I need to be able to logout

  Background:
    Given that a confirmed user exists
    And the user is logged in

  Scenario: Logging out
    When I go to the sign out link
    Then I should see "Signed out successfully" 
