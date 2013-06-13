class Seed < ActiveRecord::Base
  attr_accessible :plant, :source, :zone
  belongs_to :user

  validates :plant, presence: true, length: { maximum: 140 }
  validates :source, presence: true, length: { maximum: 140 }
  validates :zone, presence: true, length: { maximum: 2 }
  validates :user_id, presence: true

  default_scope order: 'seeds.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
