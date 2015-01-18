require 'spec_helper'

feature 'User browses the list of peeps' do

  before(:each) do
    user = User.create(
      :name => "Bibiana Cristòfol Amat",
      :user_name => "BibsBcn",
      :email => "test@test.org",
      :password_digest => "12345"
    )
    Peep.create(
      :content => "Hello World!",
      :user_id => user.id,
      :timestamp => '18 Jan'
    )
 
  end

  scenario 'when opening the home page' do
    visit '/'
    expect(page).to have_content('Hello World!')
  end

end