require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
  #new action in userscontroller
    visit new_user_url
    expect(page).to have_content("Sign Up!")
  end

  feature "signing up a user" do
    let!(:user) do
      FactoryGirl.build(:user)
    end

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on 'Create User!'
      expect(page).to have_content(user.username)
    end
  end

end

feature "logging in" do

  let!(:user) do
    FactoryGirl.create(:user)
  end

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on 'Sign In'
    expect(page).to have_content(user.username)
  end
end

feature "logging out" do

  let!(:user) do
    FactoryGirl.create(:user)
  end

  scenario "begins with logged out state" do
    visit goals_url
    expect(page).to have_content("Sign In")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit "/"
    expect(page).not_to have_content(user.username)
  end
end
