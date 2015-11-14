class Event < ActiveRecord::Base
  belongs_to :users
  belongs_to :tags
  belongs_to :location
end
