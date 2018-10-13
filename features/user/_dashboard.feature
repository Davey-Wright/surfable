Feature: user dashboard

  Scenario: Visitor tries to visit a dashboard
    Given I'm a visitor
    When I try to visit a dashboard
    Then I should be redirected to the log in page

  Scenario: Logged in user visits dashboard
    Given I'm a logged in user
    When I visit my dashboard
    Then I should see my information
