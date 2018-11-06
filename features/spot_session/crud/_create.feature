Feature: create a new session

  Background:
    Given I am logged in
    And I have an existing spot named Hardies

  Scenario: User is redirected to add new spot page
    Given I am on the 'Hardies' spot show page
    When I click the form button 'Submit'
    Then I should be redirected to the add new session page
    And I should see 'Add a new session to Hardies'
    And I should see an empty form

  Scenario: User clicks add a session to this spot
    Given I have no sessions
    And I am on the 'Hardies' spot show page
    When I click 'Add a session to to this spot'
    Then I should be redirected to the add new session page

  Scenario: User submits invalid session form
    Given I am on the add new session page
    When I click the form button 'Submit'
    Then I should see error messages telling me which fields are required

  Scenario: User cancels add new session
    Given I am currently on the add new session page
    When I click the form button 'Cancel'
    Then I should be redirected to the 'Hardies' spot show page

  Scenario: User adds a new session
    Given I am currently on the add new session page
    When I fill in the new session form
    And I click the form button 'Submit'
    Then I should be redirected to the add new session page
    And I should see 'Longboard session was successfully added to Hardies spot'
