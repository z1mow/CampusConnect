require 'rails_helper'

RSpec.describe CommunityGroup, type: :model do
  include_context "community group creation"

  describe "dependent destroy" do
    let(:member) do
      user = User.create!(
        name: "Member",
        username: "member",
        email: "member@acibadem.edu.tr",
        password: "password123"
      )
      insert_user_into_partitions(user)
      user
    end

    it "destroys associated group_members when destroyed" do
      initial_count = GroupMember.count  # Count including creator
      group_member = GroupMember.create!(user: member, community_group: group)
      expect { group.destroy }.to change { GroupMember.count }.by(-(GroupMember.count - initial_count))
    end

    it "destroys associated messages when destroyed" do
      initial_count = Message.count
      message = Message.create!(user: creator, community_group: group, body: "Test message")
      expect { group.destroy }.to change { Message.count }.by(-(Message.count - initial_count))
    end
  end
end
