require 'rails_helper'

RSpec.describe CommunityGroup, type: :model do
  include_context "community group creation"

  describe "validations" do
    it "is valid with valid attributes" do
      expect(group).to be_valid
    end

    it "is not valid without a name" do
      group.name = nil
      expect(group).not_to be_valid
    end

    it "is not valid without a description" do
      group.description = nil
      expect(group).not_to be_valid
    end

    it "is not valid without a category" do
      group.category = nil
      expect(group).not_to be_valid
    end

    it "is not valid with an invalid category" do
      group.category = "invalid_category"
      expect(group).not_to be_valid
    end
  end
end

  