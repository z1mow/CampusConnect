require 'rails_helper'

RSpec.describe CommunityGroup, type: :model do
    describe 'associations' do
      it { should belong_to(:creator).class_name('User') }
      it { should have_many(:group_members).dependent(:destroy) }
      it { should have_many(:users).through(:group_members) }
      it { should have_many(:messages).dependent(:destroy) }
    end
  end
  