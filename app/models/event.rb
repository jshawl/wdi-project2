class Event < ActiveRecord::Base
  belongs_to :location
  has_many :attendances
  has_many :users, through: :attendances
end
