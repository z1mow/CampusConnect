namespace :db do
    desc "Refresh materialized views"
    task refresh_materialized_views: :environment do
      ActiveRecord::Base.connection.execute("REFRESH MATERIALIZED VIEW group_message_summary;")
    end
  end
  