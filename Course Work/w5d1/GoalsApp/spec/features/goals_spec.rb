require 'spec_helper'
require 'rails_helper'

feature "Creating a Goal" do

  let!(:user) do
    FactoryGirl.create(:user)
  end

  let!(:goal) do
    FactoryGirl.create(:goal)
  end

  before(:each) do
    visit new_session_url
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on 'Sign In!'
  end

  scenario "Has a create goal page" do
    visit new_goal_url
    expect(page).to have_content "Create a goal!"
  end

  scenario "Fails when a user is logged out" do
    save_and_open_page
    click_on "Logout"
    visit new_goal_url
    expect(page).to have_content "Sign In!"
  end

  scenario "Saves the goal if a user is logged in" do
    visit new_goal_url

  end

end

feature "Read a Goal" do

  scenario "A user can see all their goals"

  scenario "A user can see another user's public goals"

  feature "Private Goals" do

    scenario "A user cannot see another user's private goals"

  end

end

feature "Update a goal" do
  scenario "A user can update their own goals"

  feature "Completed Goals" do
    scenario "A user can mark a goal as completed"
  end
end

feature "Delete a goal" do
  scenario "A user can delete their own goals"
end
