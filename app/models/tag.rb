class Tag < ActiveRecord::Base
  belongs_to :taggings
  belongs_to :events
end
