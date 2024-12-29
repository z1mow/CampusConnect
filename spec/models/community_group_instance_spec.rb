require 'rails_helper'

RSpec.describe CommunityGroup, type: :model do
  describe '#created_by?' do
    let(:creator) do
      User.create!(
        name: 'Jane Doe',
        username: 'janedoe', # Add valid username
        email: 'jane@live.acibadem.edu.tr', # Valid domain
        password: 'password'
      )
    end

    let(:other_user) do
      User.create!(
        name:,
        username: 'johndoe', # Add valid username
        email: 'john@live.acibadem.edu.tr', # Valid domain
        password: 'password'
      )
    end

    let(:group) { CommunityGroup.create!(name: 'Test Group', creator: creator) }

    it 'returns true if the user is the creator' do
      expect(group.created_by?(creator)).to be true
    end

    it 'returns false if the user is not the creator' do
      expect(group.created_by?(other_user)).to be false
    end
  end
end
