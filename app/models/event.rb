class Event < ActiveRecord::Base
  belongs_to :location
  has_many :attendances
  has_many :users, through: :attendances
  has_many :taggings
  has_many :tags, through: :taggings
end
