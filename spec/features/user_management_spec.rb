require 'spec_helper'

feature 'User signs up' do

  scenario 'when being a new user visiting the site' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, Bibiana Cristòfol Amat")
    expect(User.first.name).to eq("Bibiana Cristòfol Amat")
    expect(User.first.user_name).to eq("BibsBcn")
    expect(User.first.email).to eq("test@test.org")
  end

  def sign_up(name = "Bibiana Cristòfol Amat",
              user_name = "BibsBcn",
              email = "test@test.org",
              password = "12345")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :name, :with => name
    fill_in :user_name, :with => user_name
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button "Sign up"
  end

end