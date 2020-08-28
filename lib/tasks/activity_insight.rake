namespace :activity_insight do

  desc "Find duplicates for user"

  task find_duplicates: :environment do

    start = Time.now
    my_return_dups = ReturnSystemDups.new()
    my_return_dups.call
    finish = Time.now
    puts(((finish - start)/60).to_s + ' mins')

  end

  desc "Identify duplicate records from Activity Insight backup and delete them"

  task remove_duplicates: :environment do

    start = Time.now
    my_remove_dups = RemoveSystemDups.new(target = :beta)
    my_remove_dups.call
    #my_remove_dups.write
    finish = Time.now
    puts(((finish - start)/60).to_s + ' mins')

  end

  desc "Get user data from Activity Insight's psu-users.xls file"

  task get_user_data: :environment do
    Rails.application.eager_load!

    start = Time.now
    username = Rails.application.config_for(:activity_insight)["main"][:username]
    password = Rails.application.config_for(:activity_insight)["main"][:password]
    f_path = File.join('app', 'parsing_files', 'psu-users.xls')
    `bin/psu-users.sh #{username} #{password}`
    Faculty.delete_all
    my_get_user_data = GetUserData.new(f_path)
    my_get_user_data.call
    File.delete(f_path) if File.exist?(f_path)
    finish = Time.now
    puts(((finish - start)/60).to_s + ' mins')

  end

  task :delete_records, [:resource, :target] do |task, args|
    Rails.application.eager_load!

    start = Time.now
    DeleteRecords.new(args[:resource], args[:target].to_sym).delete
    finish = Time.now
    puts(((finish - start)/60).to_s + ' mins')

  end

end
