# frozen_string_literal: true

RSpec.shared_context "community group creation" do
  def insert_user_into_partitions(user)
    (0..15).each do |i|
      begin
        ActiveRecord::Base.connection.execute("INSERT INTO users_partition_#{i} (id, name, username, email, password_digest, created_at, updated_at) SELECT id, name, username, email, password_digest, created_at, updated_at FROM users WHERE id = #{user.id}")
      rescue => e
        puts "Failed to insert into partition_#{i}: #{e.message}"
      end
    end
  end

  let(:creator) do
    user = User.create!(
      name: "Creator",
      username: "creator",
      email: "creator@acibadem.edu.tr",
      password: "password123"
    )
    insert_user_into_partitions(user)
    user
  end
  
  let(:valid_attributes) do
    {
      name: "Test Group",
      description: "A test community group",
      category: "study",
      creator: creator,
      default: false
    }
  end

  let(:group) do
    CommunityGroup.create!(valid_attributes)
  end
end 