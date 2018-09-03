Feature: create a new spot
  A registered logged in user can create new spots

  Scenario: Visitor tries to visit create spot page
    Given I'm a visitor
    When I try to visit a new spot page
    Then I should be redirected to the log in page

  Scenario: User clicks add new spot button
    Given I'm currently on my spots page
    When I click add a new spot button
    Then I should be redirected to the new spot page
      And the page should have an empty form to create a new spot

  Scenario: User submits incomplete spot create form
    Given I'm currently on create a spot page
    When I leave a required field empty
      And submit the form
    Then I should still see the same form
      And errors telling me which required fields I missed

  Scenario: User cancels new spot
    Given I'm currently on create a spot page
    When I click the cancel button
    Then I should be redirected to the spots page

  Scenario: User creates a new spot
    Given I'm currently on create a spot page
    When I fill in all required fields
      And submit the form
    Then I should see a confirmation that the spot was created
      And be redirected to the newly created spot page
      And see my new spot information
