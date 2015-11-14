class Event < ActiveRecord::Base
  belongs_to :location
  has_many :users
  has_many :tags, through: :taggings
end
