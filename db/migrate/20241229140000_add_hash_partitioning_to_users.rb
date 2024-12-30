class AddHashPartitioningToUsers < ActiveRecord::Migration[7.2]
  def up
    # Mevcut users tablosunu yedekle
    execute <<-SQL
      CREATE TABLE users_backup AS TABLE users;
    SQL

    # Foreign key'leri kaldır
    execute <<-SQL
      ALTER TABLE group_members DROP CONSTRAINT IF EXISTS fk_rails_bb66f6bca8;
      ALTER TABLE messages DROP CONSTRAINT IF EXISTS fk_rails_273a25a7a6;
      ALTER TABLE friends DROP CONSTRAINT IF EXISTS fk_rails_9cfeeb4593;
      ALTER TABLE friends DROP CONSTRAINT IF EXISTS fk_rails_56804a6ce7;
      ALTER TABLE direct_messages DROP CONSTRAINT IF EXISTS fk_rails_a0333513a1;
      ALTER TABLE direct_messages DROP CONSTRAINT IF EXISTS fk_rails_94c3e36355;
      ALTER TABLE private_messages DROP CONSTRAINT IF EXISTS fk_rails_747f84c937;
      ALTER TABLE private_messages DROP CONSTRAINT IF EXISTS fk_rails_2d45700b25;
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
        department TEXT,
        title TEXT,
        student_class TEXT,
        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
      ) PARTITION BY HASH (id);
    SQL

    # Name sütunu için indeks ekleyin
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
      INSERT INTO users (id, username, name, email, password_digest, profile_picture, department, title, student_class, created_at, updated_at)
      SELECT id, username, name, email, password_digest, profile_picture, department, title, student_class, created_at, updated_at FROM users_backup;
    SQL

    # Foreign key'leri yeniden ekle
    execute <<-SQL
      ALTER TABLE group_members ADD CONSTRAINT fk_rails_bb66f6bca8 
      FOREIGN KEY (user_id) REFERENCES users(id);

      ALTER TABLE messages ADD CONSTRAINT fk_rails_273a25a7a6 
      FOREIGN KEY (user_id) REFERENCES users(id);

      ALTER TABLE friends ADD CONSTRAINT fk_rails_9cfeeb4593
      FOREIGN KEY (user_id) REFERENCES users(id);

      ALTER TABLE friends ADD CONSTRAINT fk_rails_56804a6ce7
      FOREIGN KEY (friend_id) REFERENCES users(id);

      ALTER TABLE direct_messages ADD CONSTRAINT fk_rails_a0333513a1
      FOREIGN KEY (sender_id) REFERENCES users(id);

      ALTER TABLE direct_messages ADD CONSTRAINT fk_rails_94c3e36355
      FOREIGN KEY (receiver_id) REFERENCES users(id);

      ALTER TABLE private_messages ADD CONSTRAINT fk_rails_747f84c937
      FOREIGN KEY (sender_id) REFERENCES users(id);

      ALTER TABLE private_messages ADD CONSTRAINT fk_rails_2d45700b25
      FOREIGN KEY (receiver_id) REFERENCES users(id);
    SQL

    # Yedek tabloyu kaldır
    execute <<-SQL
      DROP TABLE IF EXISTS users_backup;
    SQL
  end

  def down
    # Foreign key'leri kaldır
    execute <<-SQL
      ALTER TABLE group_members DROP CONSTRAINT IF EXISTS fk_rails_bb66f6bca8;
      ALTER TABLE messages DROP CONSTRAINT IF EXISTS fk_rails_273a25a7a6;
      ALTER TABLE friends DROP CONSTRAINT IF EXISTS fk_rails_9cfeeb4593;
      ALTER TABLE friends DROP CONSTRAINT IF EXISTS fk_rails_56804a6ce7;
      ALTER TABLE direct_messages DROP CONSTRAINT IF EXISTS fk_rails_a0333513a1;
      ALTER TABLE direct_messages DROP CONSTRAINT IF EXISTS fk_rails_94c3e36355;
      ALTER TABLE private_messages DROP CONSTRAINT IF EXISTS fk_rails_747f84c937;
      ALTER TABLE private_messages DROP CONSTRAINT IF EXISTS fk_rails_2d45700b25;
    SQL

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
      t.string :department
      t.string :title
      t.string :student_class
      t.timestamps
    end

    # Name sütunu için indeks ekle
    add_index :users, :name

    # Foreign key'leri yeniden ekle
    execute <<-SQL
      ALTER TABLE group_members ADD CONSTRAINT fk_rails_bb66f6bca8 
      FOREIGN KEY (user_id) REFERENCES users(id);

      ALTER TABLE messages ADD CONSTRAINT fk_rails_273a25a7a6 
      FOREIGN KEY (user_id) REFERENCES users(id);

      ALTER TABLE friends ADD CONSTRAINT fk_rails_9cfeeb4593
      FOREIGN KEY (user_id) REFERENCES users(id);

      ALTER TABLE friends ADD CONSTRAINT fk_rails_56804a6ce7
      FOREIGN KEY (friend_id) REFERENCES users(id);

      ALTER TABLE direct_messages ADD CONSTRAINT fk_rails_a0333513a1
      FOREIGN KEY (sender_id) REFERENCES users(id);

      ALTER TABLE direct_messages ADD CONSTRAINT fk_rails_94c3e36355
      FOREIGN KEY (receiver_id) REFERENCES users(id);

      ALTER TABLE private_messages ADD CONSTRAINT fk_rails_747f84c937
      FOREIGN KEY (sender_id) REFERENCES users(id);

      ALTER TABLE private_messages ADD CONSTRAINT fk_rails_2d45700b25
      FOREIGN KEY (receiver_id) REFERENCES users(id);
    SQL
  end
end
