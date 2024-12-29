class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true
  belongs_to :actor, polymorphic: true
  belongs_to :notifiable, polymorphic: true
end
