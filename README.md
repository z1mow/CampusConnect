# CampusConnect

### Proje Hakkında

### Özellikler

### Teknolojik Altyapı
- Ruby 3.2.2
- Ruby on Rails 7.1
- PostgreSQL
- Redis
- Node.js & Yarn
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

Eğer postgresql kurulu değilse:
```bash
brew install postgresql
brew services start postgresql
```
Not: Admin kullanıcısı oluşturulması için:
```bash
psql postgres (veya psql -U postgres)
SQL : CREATE ROLE admin WITH LOGIN SUPERUSER PASSWORD 'password';
quit
```

4. Veritabanını oluşturun:
```bash
rails db:drop
rails db:create
rails db:migrate
rails db:seed
bin/setup_db.sh
```
Not: Grup mesaj özetlerini(materialized view) güncellemek gerekirse aşağıdaki komutu çalıştırabilirsiniz:
```bash
bin/rails views:refresh_group_messages
```
5. Webpacker kurulumu:
```bash
rails webpacker:install
bin/webpack
```

6. Sunucuyu başlatın:
```bash
rails server
```

### Test
```bash
rspec
```
---

## 🌐 License
MIT License

## 📫 If there is a problem, please contact
Email: 
nilufer.gulciftci@live.acibadem.edu.tr
nursen.karadayi@live.acibadem.edu.tr
ovgu.gulec@live.acibadem.edu.tr
umut.kilinckaya@live.acibadem.edu.tr
sakir.ogut@live.acibadem.edu.tr
