class AddHashPartitioningToUsers < ActiveRecord::Migration[7.2]
  def up
    # Mevcut users tablosunu yedekle
    execute <<-SQL
      CREATE TABLE users_backup AS TABLE users;
    SQL

    # Mevcut users tablosunu kaldır
    drop_table :users, if_exists: true

    # Hash partitioned users tablosunu oluştur
    execute <<-SQL
      CREATE TABLE users (
        id BIGSERIAL PRIMARY KEY,
        username TEXT,
        name TEXT NOT NULL,
        email TEXT,
        password_digest TEXT,
        profile_picture TEXT,
        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
      ) PARTITION BY HASH (id);
    SQL

    # Name sütunu için indeks ekleyin (unique olmasına gerek yoksa sadece normal bir index bırakabilirsiniz)
    execute <<-SQL
      CREATE INDEX users_name_index ON users (name);
    SQL

    # 16 partisyon oluştur
    (0..15).each do |i|
      execute <<-SQL
        CREATE TABLE users_partition_#{i} PARTITION OF users
        FOR VALUES WITH (MODULUS 16, REMAINDER #{i});
      SQL
    end

    # Yedek tablodaki veriyi geri yükle
    execute <<-SQL
      INSERT INTO users (id, username, name, email, password_digest, profile_picture, created_at, updated_at)
      SELECT id, username, name, email, password_digest, profile_picture, created_at, updated_at FROM users_backup;
    SQL

    # Yedek tabloyu kaldır
    execute <<-SQL
      DROP TABLE IF EXISTS users_backup;
    SQL
  end

  def down
    # Partisyonları kaldır
    (0..15).each do |i|
      execute "DROP TABLE IF EXISTS users_partition_#{i};"
    end

    # Ana tabloyu kaldır
    execute "DROP TABLE IF EXISTS users;"

    # Eski users tablosunu yeniden oluştur
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :profile_picture
      t.timestamps
    end

    # Name sütunu için indeks ekle
    add_index :users, :name
  end
end
