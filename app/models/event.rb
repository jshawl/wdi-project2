class Event < ActiveRecord::Base
  belongs_to :location
  belongs_to :owner, class_name:"User", foreign_key:"user_id" #nice!
  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  acts_as_votable

  validates :title, presence: true
  validates :location, presence: true
  validates :owner, presence: true
  validates :when, presence: true

  # def self.created_today
  # self.all.where()...
  # end
  #
  # def unique_tags
  #   self.tags.uniq.. map..
  # end

end
