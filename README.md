# CampusConnect

## 🇹🇷 Türkçe

### Proje Hakkında
CampusConnect, üniversite öğrencileri için geliştirilmiş modern bir sosyal platform ve akademik yönetim sistemidir. Öğrenciler, öğretmenler ve yöneticiler arasında etkili iletişim ve işbirliği sağlar.

### Özellikler
- 👥 Kullanıcı yetkilendirme ve rol bazlı erişim sistemi
- 📚 Ders yönetimi ve akademik takvim
- 💬 Gerçek zamanlı mesajlaşma ve forum sistemi
- 📝 Ödev takip ve değerlendirme sistemi
- 📊 Akademik performans analizi
- 📱 Responsive tasarım ile mobil uyumluluk

### Teknolojik Altyapı
- Ruby 3.2.2
- Ruby on Rails 7.1
- PostgreSQL
- Redis
- Node.js & Yarn
- Hotwire (Turbo & Stimulus)
- TailwindCSS

### Kurulum
1. Ruby'nin kurulu olduğundan emin olun:
```bash
ruby -v
```

2. Projeyi klonlayın:
```bash
git clone https://github.com/yourusername/CampusConnect.git
cd CampusConnect
```

3. Gerekli gem'leri yükleyin:
```bash
bundle install
```

4. Veritabanını oluşturun:
```bash
rails db:create
rails db:migrate
```

5. Sunucuyu başlatın:
```bash
rails server
```

### Test
```bash
rspec
```

---

## 🇬🇧 English

### About
CampusConnect is a modern social platform and academic management system developed for university students. It facilitates effective communication and collaboration between students, teachers, and administrators.

### Features
- 👥 User authentication and role-based access control
- 📚 Course management and academic calendar
- 💬 Real-time messaging and forum system
- 📝 Assignment tracking and evaluation
- 📊 Academic performance analytics
- 📱 Mobile responsiveness with responsive design

### Tech Stack
- Ruby 3.2.2
- Ruby on Rails 7.1
- PostgreSQL
- Redis
- Node.js & Yarn
- Hotwire (Turbo & Stimulus)
- TailwindCSS

### Installation
1. Ensure Ruby is installed:
```bash
ruby -v
```

2. Clone the project:
```bash
git clone https://github.com/yourusername/CampusConnect.git
cd CampusConnect
```

3. Install required gems:
```bash
bundle install
```

4. Veritabanını kurun:
```bash
bin/setup_db.sh
```
Not: Grup mesaj özetlerini güncellemek için aşağıdaki komutu çalıştırın:
```bash
bin/rails views:refresh_group_messages
```

5. Start the server:
```bash
rails server
```

### Testing
```bash
rspec
```

## 🌐 License
MIT License

## 📫 Contact
Email: your.email@example.com
