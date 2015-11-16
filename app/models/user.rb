class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :attendances
  has_many :events, through: :attendances
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  # has_many :users, :source => :friends, through: :friendships

end
