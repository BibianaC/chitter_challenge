require 'spec_helper'

feature 'User signs up' do

  scenario 'when being a new user visiting the site' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, Bibiana Cristòfol Amat")
    expect(User.first.name).to eq("Bibiana Cristòfol Amat")
    expect(User.first.user_name).to eq("BibsBcn")
    expect(User.first.email).to eq("test@test.org")
  end

  scenario 'with a password that doesn\'t match' do
    expect{ sign_up('B', 'bib', 'b@b.org', 'pass', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario 'with an email that is already registered' do
    expect{ sign_up }.to change(User, :count).by(1)
    expect{ sign_up }.to change(User, :count).by(0)
    expect(page).to have_content("This email is already registered")
  end

  scenario 'with a user name that is already registered' do
    expect{ sign_up }.to change(User, :count).by(1)
    expect{ sign_up }.to change(User, :count).by(0)
    expect(page).to have_content("This user name is already registered")
  end

  def sign_up(name = "Bibiana Cristòfol Amat",
              user_name = "BibsBcn",
              email = "test@test.org",
              password = "12345",
              password_confirmation = "12345")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :name, :with => name
    fill_in :user_name, :with => user_name
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end

end