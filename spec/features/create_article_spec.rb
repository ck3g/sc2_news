require 'spec_helper'

feature 'Create article' do
  given!(:user) { create :admin_example_com }

  scenario "with valid data" do
    sign_in_as 'admin', 'secret'
    visit new_article_path

    within "#new_article" do
      fill_in 'article_title', with: 'New article'
      fill_in 'article_body', with: 'New article body'
      click_button I18n.t('helpers.submit.article.create')
    end

    expect(Article.count).to eq 1
    expect(page).to have_content 'New article'
    expect(page).to have_content 'New article body'
  end
end
