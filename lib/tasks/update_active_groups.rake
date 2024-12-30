namespace :groups do
  desc 'Grup istatistiklerini güncelle'
  task refresh_stats: :environment do
    puts "Grup istatistikleri güncelleniyor..."
    ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW group_message_summary;')
    puts "✅ Güncelleme tamamlandı!"
  end
end 