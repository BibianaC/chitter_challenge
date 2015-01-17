require 'spec_helper'
require_relative 'helpers/session'

feature 'User signs up' do

  include SessionHelpers

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

end

feature 'User logs in' do

  include SessionHelpers

  before(:each) do
    User.create(:name => 'Bibiana Cristòfol Amat',
                :user_name => 'BibsBcn',
                :email => "test@test.org",
                :password => '12345',
                :password_confirmation => '12345')
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, Bibiana Cristòfol Amat")
    log_in('test@test.org', '12345')
    expect(page).to have_content("Welcome, Bibiana Cristòfol Amat")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, Bibiana Cristòfol Amat")
    log_in('test@test.org', 'wrong')
    expect(page).not_to have_content("Welcome, Bibiana Cristòfol Amat")
  end

end

feature 'User logs out' do

  include SessionHelpers

  before(:each) do
    User.create(:name => 'Bibiana Cristòfol Amat',
                :user_name => 'BibsBcn',
                :email => "test@test.org",
                :password => '12345',
                :password_confirmation => '12345')
  end

  scenario 'while being logeded in' do
    log_in('test@test.org', '12345')
    click_button "Log out"
    expect(page).to have_content("Good bye!")
    expect(page).not_to have_content("Welcome, Bibiana Cristòfol Amat")
  end


end

