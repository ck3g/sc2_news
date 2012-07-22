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
  end
end
