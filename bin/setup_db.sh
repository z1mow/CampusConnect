#!/bin/bash

echo "🔄 Veritabanı kurulumu başlatılıyor..."

# PostgreSQL bağlantı bilgileri
export PGPASSWORD=password

# Rails veritabanı işlemleri
echo "📦 Rails veritabanı oluşturuluyor..."
RAILS_ENV=development bin/rails db:drop
RAILS_ENV=development bin/rails db:create
echo "🔧 Rails migrasyonları çalıştırılıyor..."
RAILS_ENV=development bin/rails db:migrate

# Materyalleştirilmiş görünüm oluşturma
echo "👀 Materyalleştirilmiş görünüm oluşturuluyor..."
PGPASSWORD=$PGPASSWORD psql -U admin -d myapp_development -c "DROP MATERIALIZED VIEW IF EXISTS group_message_summary;"
PGPASSWORD=$PGPASSWORD psql -U admin -d myapp_development -f db/sql/group_message_summary.sql

echo "✅ Veritabanı kurulumu tamamlandı!" 