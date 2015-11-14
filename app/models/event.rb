class Event < ActiveRecord::Base
  has_many :users
  has_many :tags, through: :taggings
  belongs_to :location
end
