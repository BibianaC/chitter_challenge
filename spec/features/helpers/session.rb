module SessionHelpers

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

  def log_in(email, password)
    visit '/sessions/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button 'Log in'
  end

end