class ChangeEventWhenToTime < ActiveRecord::Migration
  def change
    change_column :events, :when, :time
  end
end
