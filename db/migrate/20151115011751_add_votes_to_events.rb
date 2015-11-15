class AddVotesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :upvotes, :integer, :default => 0
    add_column :events, :downvotes, :integer, :default => 0
  end
end
