class Location < ActiveRecord::Base
  has_many :events

  # geocoded_by :address
  # after_validation :geocode, :if => :address_changed?

  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

end
