require 'spec_helper'

feature 'User browses the list of links' do
  
  before (:each) {
    Peep.create(:content => 'Hello World!',
                :user_id => '1')
  }

  scenario 'when opening the home page' do
    visit '/'
    expect(page).to have_content('Hello World!')
  end

end