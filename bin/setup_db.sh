#!/bin/bash

echo "🔄 Veritabanı kurulumu başlatılıyor..."

# Rails veritabanı işlemleri
echo "📦 Rails veritabanı oluşturuluyor..."
bin/rails db:create
echo "🔧 Rails migrasyonları çalıştırılıyor..."
bin/rails db:migrate

# Materyalleştirilmiş görünüm oluşturma
echo "👀 Materyalleştirilmiş görünüm oluşturuluyor..."
psql -d myapp_development -f db/sql/group_message_summary.sql

echo "✅ Veritabanı kurulumu tamamlandı!" 