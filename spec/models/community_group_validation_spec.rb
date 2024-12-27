require 'rails_helper'

RSpec.describe CommunityGroup, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      creator = User.create!(
        name: 'John Doe',
        username: 'johndoe',
        email: 'john@live.acibadem.edu.tr', # Valid domain
        password: 'password'
      )
      group = CommunityGroup.new(name: 'Test Group', creator: creator)

      expect(group).to be_valid
    end

    it 'is invalid without a name' do
      creator = User.create!(
        name: 'John Doe',
        username: 'johndoe',
        email: 'john@live.acibadem.edu.tr', # Valid domain
        password: 'password'
      )
      group = CommunityGroup.new(creator: creator)

      expect(group).not_to be_valid
      expect(group.errors[:name]).to include("can't be blank")
    end
  end
end

  