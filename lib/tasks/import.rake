namespace :import do
  desc "Import users from MSSQL"
  task :users => :environment do
    puts "Importing users..."

    ActiveRecord::Base.connection.execute("TRUNCATE users")
    ActiveRecord::Base.connection.execute("TRUNCATE profiles")

    total_users = ScOld::Membership.count
    $stdout.sync = true
    ScOld::Membership.order(:CreateDate).each_with_index do |membership, index|
      old_user = ScOld::User.find_by_UserId(membership.UserId)
      old_profile = ScOld::Profile.find_by_user_id(membership.UserId)

      if old_user.present? && old_profile.present?
        pass = rand(10000) + 100000
        user = User.new :email => membership.Email, :password => pass, :password_confirmation => pass, :created_at => membership.CreateDate,
                            :old_id => membership.UserId, :user_name => old_user.UserName

        unless user.valid?
          puts "\nfailed create user: #{user.errors.messages}"
          puts "for #{old_user.UserName} [#{membership.Email}]"
          next
        end
        user.save

        user.profile.country_id       = old_profile.country_id
        user.profile.race             = old_profile.race
        user.profile.bnet_name        = old_profile.bnet_name
        user.profile.bnet_server      = old_profile.bnet_server
        user.profile.league           = old_profile.league
        user.profile.experience       = old_profile.experience
        user.profile.first_name       = old_profile.first_name
        user.profile.last_name        = old_profile.last_name
        user.profile.details          = old_profile.details
        user.profile.avatar_style     = old_profile.avatar_style
        user.profile.achievements     = old_profile.achievements
        user.profile.rank             = old_profile.rank
        user.profile.points           = old_profile.points
        user.profile.wins             = old_profile.wins
        user.profile.loses            = old_profile.loses
        user.profile.win_rate         = old_profile.win_rate
        user.profile.profile_url      = old_profile.profile_url
        user.profile.synchronized_at  = old_profile.synchronized_at

        user.profile.save
      end
      print "\r#{index + 1} of #{total_users} imported"
    end
    puts "\ndone"
  end

  desc "Import news from MSSQL"
  task :news => :environment do
  end
end
