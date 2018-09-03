Feature: update a spot
  A registered logged in user can update their spots

  Scenario: Visitor tries to visit a spot update page
    Given I'm a visitor
    When I try to visit a spot update page
    Then I should be redirected to the log in page

  Scenario: User clicks edit spot button
    Given I'm currently on a spot page
    When I click edit spot button
    Then I should be redirected to the update spot form page
      And the page should have form
      And it should be prefilled with exisiting spot information

  Scenario: User submits incomplete spot update form
    Given I'm currently on a spot update page
    When I leave a required field empty
      And submit the form
    Then I should still see the same form
      And errors telling me which required fields I missed

  Scenario: User cancels spot update
    Given I'm currently on spot update page
    When I click the cancel button
    Then I should be redirected to the spot page

  Scenario: User updates spot
    Given I'm currently on spot update page
    When I fill in all required fields
      And submit the form
    Then I should see a confirmation that the spot was updated
      And be redirected to the newly created spot page
      And see my new spot information
