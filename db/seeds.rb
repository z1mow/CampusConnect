# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#if Rails.env.development? || Rails.env.test?
#    User.transaction do
#      1.upto(1000) do |i|
#        User.create!(
#          email: "user#{i}@live.acibadem.edu.tr",
#          username: "user#{i}",
#          password: "password#{i}",
#          name: "User #{i}"
#        )
#      end
#    end
#  else
#    puts "Bu script sadece test veya development ortamında çalıştırılabilir."
#  end
admin = User.create!(
  name: 'Admin User',
  username: 'admin',
  email: 'admin@live.acibadem.edu.tr',
  password: '123456',
  password_confirmation: '123456',
  department: 'Computer_Science',
  title: 'Student'
)

test_user = User.create!(
  name: 'Test User',
  username: 'test',
  email: 'test@live.acibadem.edu.tr',
  password: '123456',
  password_confirmation: '123456',
  department: 'Computer_Science',
  title: 'Student'
)

# Test arkadaşlık ilişkisi oluştur
Friend.create!(
  user: admin,
  friend: test_user,
  status: 'accepted'
)

CommunityGroup.create!([
  { name: "Kadın Hakları Grubu", creator_id: admin.id, default: true, category:"other", description:"A"},
  { name: "Hayvan Hakları Grubu", creator_id: admin.id, default: true, category:"other", description:"A"},
  { name: "İnsan Hakları Grubu", creator_id: admin.id, default: true, category: "other", description:"A"},
  { name: "Okul Hakkında Şikayet", creator_id: admin.id, default: true, category: "other", description:"A"}
])
