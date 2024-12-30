require 'rails_helper'

RSpec.describe CommunityGroup, type: :model do
  describe "#created_by?" do
    let(:creator) { User.create!(name: "Creator", username: "creator", email: "creator@acibadem.edu.tr", password: "password123") }
    let(:other_user) { User.create!(name: "Other", username: "other", email: "other@acibadem.edu.tr", password: "password123") }
    let(:group) do
      # Create group without running callbacks
      group = CommunityGroup.new(
        name: "Test Group",
        description: "A test group",
        category: "study",
        creator: creator,
        default: false
      )
      # Stub the add_creator_as_member method to do nothing
      allow(group).to receive(:add_creator_as_member)
      group.save(validate: false)
      group
    end

    it "returns true if the user is the creator" do
      expect(group.created_by?(creator)).to be true
    end

    it "returns false if the user is not the creator" do
      expect(group.created_by?(other_user)).to be false
    end
  end
end
