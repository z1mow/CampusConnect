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
admin_user = User.create!(
  name: "admin",
  username: "admin",
  email: "admin@acibadem.edu.tr",
  password: "password",
  password_confirmation: "password"
)

CommunityGroup.create!([
  { 
    name: "Kadın Hakları Grubu", 
    creator_id: admin_user.id, 
    default: true, 
    category: "other", 
    description: "Üniversite kampüsünde kadın haklarını savunan, farkındalık oluşturan ve dayanışmayı güçlendiren bir topluluk. Birlikte daha güçlüyüz!"
  },
  { 
    name: "Hayvan Hakları Grubu", 
    creator_id: admin_user.id, 
    default: true, 
    category: "other", 
    description: "Kampüsteki dostlarımızın sesi olmak, onları korumak ve yaşam haklarını savunmak için bir araya gelen gönüllüler topluluğu."
  },
  { 
    name: "İnsan Hakları Grubu", 
    creator_id: admin_user.id, 
    default: true, 
    category: "other", 
    description: "Temel insan haklarını savunan, ayrımcılıkla mücadele eden ve eşit bir dünya için çalışan öğrenci topluluğu."
  },
  { 
    name: "Okul Hakkında Şikayet", 
    creator_id: admin_user.id, 
    default: true, 
    category: "other", 
    description: "Öğrencilerin eğitim kalitesini artırmak için görüş, öneri ve şikayetlerini paylaşabildiği yapıcı iletişim platformu."
  }
])
