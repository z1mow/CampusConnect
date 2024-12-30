namespace :views do
  desc 'Grup mesaj özetlerini güncelle'
  task refresh_group_messages: :environment do
    ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW group_message_summary;')
    puts "✨ Grup mesaj özetleri güncellendi!"
  end
end 