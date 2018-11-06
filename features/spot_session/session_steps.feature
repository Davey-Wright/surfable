Given I am logged in
Given I am on the 'Hardies' spot show page
Given I am on the 'Longboard' session show page
Given I am on the 'Longboard' session edit page
Given I am on the add new session page
Given there is a 'link' link
Given I clicked 'Delete session'

Given I have no sessions

When I click the form button 'button'
When I click 'click'

When I visit the 'Hardies' spot page

When I fill in the new session form
When I fill in the update session form

And I am prompted to confirm delete

And I am on the 'Hardies' spot show page
And I am on the 'Longboard' session page

And I have an existing spot named 'Hardies'
And I have an existing session named 'Longboard session'

And I click the form button 'button'

And I should see an empty form
And I should see 'string'
And I should not see the session 'Longboard'


Then I should see the 'Longboard' session
Then I should see error messages telling me which fields are required

Then I should be redirected to the add new session page
Then I should be redirected to the 'Hardies' spot show page
Then I should be redirected to the 'Longboard' session show page
Then I should be redirected to the 'Longboard' session edit page

Then I should be prompted to confirm delete session
Then I should remain on the 'Longboard' session page
