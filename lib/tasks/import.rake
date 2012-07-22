namespace :import do
  desc "Import users from MSSQL"
  task users: :environment do
    puts "Importing users..."

    # ActiveRecord::Base.connection.execute("TRUNCATE users")
    # ActiveRecord::Base.connection.execute("TRUNCATE profiles")

    total_users = Legacy::Membership.count
    $stdout.sync = true
    Legacy::Membership.order(:CreateDate).each_with_index do |membership, index|
      legacy_user = Legacy::User.find_by_UserId(membership.UserId)
      legacy_profile = Legacy::Profile.find_by_user_id(membership.UserId)

      if legacy_user.present? && legacy_profile.present?
        user = legacy_user.import(membership)
        legacy_profile.import(user.profile)
      end
      print "\r#{index + 1} of #{total_users} imported"
    end
    puts "\ndone"
  end

  desc "Import news from MSSQL"
  task news: :environment do
    puts "Importing news..."
    legacy_news_ids = Legacy::News.order(:created_at).pluck(:id)
    total = legacy_news_ids.count
    $stdout.sync = true
    legacy_news_ids.each_with_index do |legacy_id, index|
      Legacy::News.import(legacy_id)
      print "\r#{index + 1} of #{total} imported"
    end

    puts "\ndone"
  end

  desc "Import comments"
  task comments: :environment do
    puts "Importing comments..."
    articles = Article.all
    total = articles.count
    $stdout.sync = true

    ActiveRecord::Base.connection.execute("TRUNCATE comments")
    articles.each_with_index do |article, index|
      legacy_comments = Legacy::Comment.where(parent_id: article.legacy_id)
      legacy_comments.each_with_index do |comment|
        comment.import(article)
      end

      print "\r#{index + 1} of #{total} articles imported"
    end

    puts "\ndone"
  end

  desc "Import tags and link them to articles"
  task tags: :environment do
    puts "Importing tags..."
    legacy_tags = Legacy::Tag.all
    total = legacy_tags.count
    $stdout.sync = true
    legacy_tags.each_with_index do |legacy_tag, index|
      legacy_tag.import
      print "\r#{index + 1} of #{total} imporded"
    end

    puts "\ndone"

    Rake::Task["import:link_tags_and_articles"].invoke
  end

  task link_tags_and_articles: :environment do
    puts "Linking tags and articles..."
    articles = Article.all
    total = articles.count
    $stdout.sync = true
    articles.each_with_index do |article, index|
      legacy_tag_ids = Legacy::NewsTag.where(news_id: article.legacy_id).pluck(:tag_id)
      article.tags = Tag.where(legacy_id: legacy_tag_ids)
      print "\r#{index + 1} of #{total} linked"
    end

    puts "\ndone"
  end
end
