class Tagging < ActiveRecord::Base
  belongs_to :event
  belongs_to :tag
  belongs_to :user

  validates :event, presence: true
  validates :tag, presence: true, allow_nil: false
  validates :user, presence: true

end
