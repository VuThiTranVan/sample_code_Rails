class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  scope :follower_of_user, ->user_id{where follower_id: user_id}
  # SELECT followed_id FROM relationships WHERE follower_id = :user_id
end
