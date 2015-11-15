class AddUserToTaggings < ActiveRecord::Migration
  def change
    add_reference :taggings, :user, index: true, foreign_key: true
  end
end
