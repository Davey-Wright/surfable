Feature: create a new session

  Background:
    Given I am logged in
    And I have an existing spot named 'Hardies'
    And I have an existing session named 'Longboard'

  Scenario: User clicks edit session
    Given I am on the 'Longboard' session show page
    When I click 'Edit'
    Then I should be redirected to the 'Longboard' session edit page

  Scenario: User submits invalid edit form
    Given I am on the 'Longboard' edit page
    When I click the form button 'Update'
    Then I should see error messages telling me which fields are required

  Scenario: User cancels update session
    Given I am on the 'Longboard' session edit page
    When I click the form button 'Cancel'
    Then I should be redirected to the 'Hardies' spot show page

  Scenario: User updates session
    Given I am on the 'Longboard' session edit page
    When I fill in the update session form
    And I click the form button 'Update'
    Then I should be redirected to the 'Hardies' spot show page
    And I should see 'Hardies Longboard session was successfully updated'
