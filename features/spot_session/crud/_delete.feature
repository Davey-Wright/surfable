Feature: delete a session

  Background:
    Given I am logged in
    And I have an existing spot named 'Hardies'
    And I have an existing session named 'Longboard'
    And I am on the 'Longboard' session page

  Scenario: User clicks delete spot
    Given there is a 'Delete session' link
    When I click 'Delete session'
    Then I should be prompted to confirm delete session

  Scenario: User cancels delete spot
    Given I clicked 'Delete session'
    And I am prompted to confirm delete
    When I click the form button 'Cancel'
    Then I should remain on the 'Longboard' session page

  Scenario: User confirms delete spot
    Given I clicked 'Delete session'
    And I am prompted to confirm delete
    When I click 'Confirm'
    Then I should be redirected to the 'Hardies' spot show page
    And I should see 'Hardies Longboard session was successfully deleted from Hardies'
    And I should not see the session 'Longboard'
