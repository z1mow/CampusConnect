require 'rails_helper'

RSpec.describe CommunityGroup, type: :model do
  describe 'dependent destroy' do
    let(:creator) do
      User.create!(
        name: 'Jane Doe',
        username: 'janedoe', # Valid username
        email: 'jane@live.acibadem.edu.tr', # Valid email
        password: 'password'
      )
    end

    let(:user) do
      User.create!(
        name: 'John Doe',
        username: 'johndoe', # Valid username
        email: 'john@live.acibadem.edu.tr', # Valid email
        password: 'password'
      )
    end

    let(:group) { CommunityGroup.create!(name: 'Test Group', creator: creator) }

    it 'destroys associated group_members when destroyed' do
      group.group_members.create!(user: user)
      expect { group.destroy }.to change { GroupMember.count }.by(-1)
    end

    it 'destroys associated messages when destroyed' do
      group.messages.create!(body: 'Hello, world!', user: creator)
      expect { group.destroy }.to change { Message.count }.by(-1)
    end
  end
end
