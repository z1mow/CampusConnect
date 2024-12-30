class CommunityGroup < ApplicationRecord
    belongs_to :creator, class_name: "User"
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
    validates :category, presence: true, inclusion: { 
      in: %w[study club project department other],
      message: "%{value} geçerli bir kategori değil" 
    }

    # Many-to-many relationship with User through GroupMember
    has_many :group_members, dependent: :destroy
    has_many :users, through: :group_members
    has_many :messages, dependent: :destroy

    after_create :add_creator_as_member

    def badge_text
      if is_most_active_group?
        'En Aktif Grup 👑'
      else
        ''
      end
    end

    def is_most_active_group?
      result = ActiveRecord::Base.connection.execute(
        "SELECT community_group_id 
         FROM group_message_summary 
         WHERE message_count = (SELECT MAX(message_count) FROM group_message_summary)
         LIMIT 1"
      ).first
      
      result && result['community_group_id'] == id
    end

    def last_message_time
      result = ActiveRecord::Base.connection.execute(
        "SELECT last_message_at 
         FROM group_message_summary 
         WHERE community_group_id = #{id}"
      ).first

      if result && result['last_message_at']
        time_ago = ((Time.current - result['last_message_at'].to_time) / 60).round
        "Son mesajın üzerinden #{time_ago} dakika geçti"
      else
        "Henüz mesaj yok"
      end
    end

    private

    def add_creator_as_member
        users << creator unless users.include?(creator)
    end
end
  
