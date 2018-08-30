Feature: User deletes their spot
  A registered logged in user can delete their spots

  Scenario: User clicks delete spot
    Given I'm currently on spot update page
    When I click the delete spot button
    Then I should be prompted to confirm I want to delete the spot

  Scenario: User cancels delete spot
    Given I've clicked the delete spot button
    When I'm prompted to confirm to delete spot
      And I click cancel
    Then the prompt should disapper
      And I should still be on the spot update page

  Scenario: User confirms delete spot
    Given I've clicked the delete spot button
    When I'm prompted to confirm to delete spot
      And I click confirm
    Then I should see a confirmation that the spot was deleted
      And be redirected to my spots page
      And should not see my recently deleted spot
