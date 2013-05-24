require 'spec_helper'

feature 'Sign in' do
  given!(:user) do
    create :user, email: 'green@arrow.com', username: 'Oliver'
  end

  scenario 'signing in thru quick form' do
    sign_in_as 'green@arrow.com', 'secret'
    page.should have_content 'Oliver'
  end
end
