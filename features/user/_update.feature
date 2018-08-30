Feature: User updates profile information
  A registered logged in user can update their profile

Scenario: User clicks edit profile button
  Given I'm currently on my profile page
  When I click edit profile button
  Then I should be redirected to the update profile form page
    And the page should have form
    And it should be prefilled with exisiting profile information

Scenario: User submits incomplete profile update form
  Given I'm currently on a profile update page
  When I leave a required field empty
    And submit the form
  Then I should still see the same form
    And errors telling me which required fields I missed

Scenario: User cancels profile update
  Given I'm currently on profile update page
  When I click the cancel button
  Then I should be redirected to my profile page

Scenario: User updates profile
  Given I'm currently on profile update page
  When I fill in all required fields
    And submit the form
  Then I should be redirected to my profile page
    And see my updated profile information
