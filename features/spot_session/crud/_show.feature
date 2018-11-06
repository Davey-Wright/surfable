Feature: View a session page

  Background:
    Given I am logged in
    And I have an existing spot named 'Hardies'
    And I am on the 'Hardies spot' show page
    And I have an existing session named 'Longboard session'

  Scenario: User views Longboard session page
    Given there is a 'View session' link
    When I click 'View session'
    Then I should be redirected to the 'Longboard' session show page
