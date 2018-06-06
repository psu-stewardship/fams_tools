require 'activity_insight/ai_manage_duplicates'
require 'activity_insight/ai_get_userids'

namespace :activity_insight do

  desc "Find duplicates for user"

  task find_duplicates: :environment do

    start = Time.now
    my_return_dups = ReturnSystemDups.new
    my_return_dups.call
    finish = Time.now
    puts(((finish - start)/60).to_s + ' mins')

  end

  desc "Identify duplicate records from Activity Insight backup and delete them"

  task remove_duplicates: :environment do

    start = Time.now
    my_remove_dups = RemoveSystemDups.new
    my_remove_dups.call
    my_remove_dups.write
    finish = Time.now
    puts(((finish - start)/60).to_s + ' mins')

  end

  desc "Import userids from AI into our db"

  task import_userids: :environment do
    
    start = Time.now
    my_import_ids = ImportUserids.new
    my_import_ids.call
    finish = Time.now
    puts(((finish - start)/60).to_s + ' mins')

  end

end
