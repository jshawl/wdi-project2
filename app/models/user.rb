class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :attendances
  has_many :events, through: :attendances
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :active_relationships,  class_name:  "Following",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Following",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  acts_as_voter

  # Follows a user.
  def follow(other_user)
    # unless current_user.id == other_user.id
      active_relationships.create(followed_id: other_user.id)
    # end
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

end
