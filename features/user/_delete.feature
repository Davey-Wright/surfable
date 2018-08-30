Feature: User deletes their profile
  A registered logged in user can delete their profile

  Scenario: User clicks delete profile
    Given I'm currently on profile update page
    When I click the delete profile button
    Then I should be prompted to confirm I want to delete the profile

  Scenario: User cancels delete profile
    Given I've clicked the delete profile button
    When I'm prompted to confirm to delete profile
      And I click cancel
    Then the prompt should disapper
      And I should still be on the profile update page

  Scenario: User confirms delete profile
    Given I've clicked the delete profile button
    When I'm prompted to confirm to delete profile
      And I click confirm
    Then I should see a confirmation that my profile was deleted
      And be redirected to the homepage
