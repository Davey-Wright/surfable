Given("I am a visitor") do
  nil
end

When("I click on the Sign Up button in the top navigation") do
  click_link('#sign_up')
end

Then("I should be redirected to the sign up page") do
  redirect_to(new_user_registration)
  expect(page).to have_content('Sign up')
end

Given("I'm currently on the user registration page") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should be redirected to the homepage") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should be redirected to my user dashboard") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("see my user information") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I click the sign up with facebook button") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I fill in the form with incorrect facebook credentials") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I fill in the form with correct facebook credentials") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should be redirected to my dashboard") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I click the sign up with google button") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I fill in the form with incorrect google credentials") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I fill in the form with correct google credentials") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I try to visit a dashboard") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("I'm a logged in user") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I visit my dashboard") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see my information") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("I'm currently on profile update page") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I click the delete profile button") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should be prompted to confirm I want to delete the profile") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("I've clicked the delete profile button") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I'm prompted to confirm to delete profile") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should still be on the profile update page") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see a confirmation that my profile was deleted") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("be redirected to the homepage") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("I'm currently on my profile page") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I click edit profile button") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should be redirected to the update profile form page") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("it should be prefilled with exisiting profile information") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("I'm currently on a profile update page") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should be redirected to my profile page") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("see my updated profile information") do
  pending # Write code here that turns the phrase above into concrete actions
end
