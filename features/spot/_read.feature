Feature: User views their spots
  A registered logged in user can view their spots

Scenario: Visitor tries to visit spots page
  Given I'm a visitor
  When I try to visit my spots
  Then I should be redirected to the log in page

Scenario: Visitor tries to visit a spot
  Given I'm a visitor
  When I try to visit a spot
  Then I should be redirected to the log in page

Scenario: User with no spots visits their spots page
  Given I don't have any spots
  When I visit my spots
  Then I should see a blank page
    And a heading telling me I do not have any spots

Scenario: User tries to visit non existent spot
  Given I don't have any spots
  When I visit a spot that doesn't exist
  Then I should be directed to a not found page

Scenario: User with existing spots visits their spots page
  Given I have at least one spot
  When I visit my spots page
  Then I should see information about all of my spots

Scenario: User visits a spot
  Given I have at least one spot
  When I visit a spot
  Then I should see the spot information
    And should see the spots forecast
