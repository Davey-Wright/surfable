Feature: register new user
  To use app features other than forecasts a user has to be registered and logged in.

  Scenario: Visitor visits sign up page
    Given I am a visitor on the homepage
    When I click on the Sign Up button in the top navigation
    Then I should be redirected to the sign up page

  Scenario: Visitor submits incomplete registration form
    Given I'm currently on the user registration page
    When I fill in the user registration form
      But leave a required field empty
      And submit the form
    Then I should still see the same form
      And errors telling me which required fields I missed

  Scenario: Visitor cancels new registration
    Given I'm currently on the user registration page
    When I click the cancel button
    Then I should be redirected to the homepage

  Scenario: Visitor clears new registration
    Given I'm currently on the user registration page
    When I fill in the user registration form
      And click the clear button
    Then The form fields should be cleared

  Scenario: Visitor successfully registers
    Given I'm currently on the user registration page
    When I fill in all required fields
      And submit the form
    Then I should be redirected to my user dashboard
      And see my user information

  Scenario: Visitor fails Facebook registration
    Given I'm currently on the user registration page
    When  I click the sign up with facebook button
      And I fill in the form with incorrect facebook credentials
    Then I should still see the same form
      And errors telling me which required fields I missed

  Scenario: Visitor registers with Facebook
    Given I'm currently on the user registration page
    When  I click the sign up with facebook button
      And I fill in the form with correct facebook credentials
    Then I should be redirected to my dashboard

  Scenario: Visitor fails Google registration
    Given I'm currently on the user registration page
    When  I click the sign up with google button
      And I fill in the form with incorrect google credentials
    Then I should still see the same form
      And errors telling me which required fields I missed

  Scenario: Visitor registers with Google
    Given I'm currently on the user registration page
    When  I click the sign up with google button
      And I fill in the form with correct google credentials
    Then I should be redirected to my dashboard
