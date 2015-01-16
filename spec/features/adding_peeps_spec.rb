require 'spec_helper'

feature 'User adds a new link' do

  before(:each) do
   User.create(
      :name => "Bibiana Cristòfol Amat",
      :user_name => "BibsBcn",
      :email => "test@test.org",
      :password_digest => "12345"
    )
    user = User.last
    Peep.create(
      :content => "Hello world!",
      :user_id => user.id
    )
  end
  
  scenario 'when browsing the homepage' do
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.content).to eq('Hello world!')
  end



end