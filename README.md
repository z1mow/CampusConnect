# 🎓 CampusConnect

### About the Project

CampusConnect is an online communication platform that encourages university members to share concerns, raise awareness, and collaborate on issues such as women's rights and campus safety.

It provides an inclusive environment that facilitates communication through group chats, ensuring everyone stays informed and involved.

CampusConnect's mission is to strengthen connections and make communication more accessible within the school, creating an inclusive environment that ensures everyone is informed and involved.

### Technical Stack
- Ruby 3.2.2
- Ruby on Rails 7.1
- PostgreSQL (Database)
- Redis (for Caching and ActionCable)


### Installation

### Prerequisites
- Ruby 3.2.2
- PostgreSQL
- Redis
- Node.js & Yarn

### Step by Step Setup
1. Make sure Ruby is installed:
```bash
ruby -v
```

2. Clone the project:
```bash
git clone https://github.com/z1mow/CampusConnect.git
cd CampusConnect
```

3. Install required gems:
```bash
bundle install
```

4. PostgreSQL setup (if not installed):
```bash
brew install postgresql
brew services start postgresql 
(if it doesn't work: /opt/homebrew/opt/postgresql@14/bin/postgres -D /opt/homebrew/var/postgresql@14)
```
Note: To create an admin user:
```bash
psql postgres (or psql -U postgres)
SQL: CREATE ROLE admin WITH LOGIN SUPERUSER PASSWORD 'password';
\q
```

5. Database setup:
```bash
rails db:drop
rails db:create
rails db:migrate
rails db:seed
rails db:migrate:redo VERSION=20241230200100  # Creates materialized view
```
Note: To refresh group message summaries (materialized view), you can run:
```bash
bin/rails views:refresh_group_messages
```
5. Webpacker setup:
```bash
rails webpacker:install
bin/webpack
```

7. Start the server:
```bash
rails server
```
---

## 🤝 Contributing
1. Fork the project
2. Create your feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

## 📝 License
This project is licensed under the MIT License.

## 👥 Team
- Nilüfer Gülçiftçi
- Nursen Karadayı
- Övgü Güleç
- Umut Kılınçkaya
- Şakir Öğüt

## 📫 Contact
For any questions or suggestions:

- nilufer.gulciftci@live.acibadem.edu.tr
- nursen.karadayi@live.acibadem.edu.tr
- ovgu.gulec@live.acibadem.edu.tr
- umut.kilinckaya@live.acibadem.edu.tr
- sakir.ogut@live.acibadem.edu.tr

## 🙏 Acknowledgments
Thanks to everyone who has contributed to this project!
