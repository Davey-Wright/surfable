Feature: View a session

  Background:
    Given I am logged in
    And I have an existing spot named 'Hardies'

  Scenario: User does not have any sessions
    Given I have no sessions
    When I visit the 'Hardies' spot page
    Then I should see 'Add a session to to this spot'

  Scenario: User views 'Hardies' sessions list
    Given I have an existing session named 'Longboard session'
    When I visit the 'Hardies' spot page
    Then I should see the 'Longboard' session
