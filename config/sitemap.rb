# Set the host name for URL creation

rails_env = ENV['RAILS_ENV'] || 'development'

SitemapGenerator::Sitemap.default_host = "http://starcraft.md"
SitemapGenerator::Sitemap.public_path = 'public/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  #

  add articles_path, priority: 0.7, changefreq: 'daily'
  add tags_path, changefreq: 'daily'
  add new_user_password_path, changefreq: 'monthly'
  add new_user_registration_path, changefreq: 'monthly'
  add new_user_session_path, changefreq: 'monthly'

  Article.find_each do |article|
    add article_path(article), lastmod: article.updated_at
  end

  Page.find_each do |page|
    add page_path(page.permalink), lastmod: page.updated_at, changefreq: 'monthly'
  end

  User.find_each do |user|
    add user_profile_path(user.username), lastmod: user.profile.updated_at, changefreq: 'weekly'
  end

  Tag.find_each do |tag|
    add tagged_articles_path(tag.name), changefreq: 'daily'
  end
end
