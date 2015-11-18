class Event < ActiveRecord::Base
  belongs_to :location
  belongs_to :owner, class_name:"User", foreign_key:"user_id"
  has_many :attendances
  has_many :users, through: :attendances
  has_many :taggings
  has_many :tags, through: :taggings
  acts_as_votable
end
