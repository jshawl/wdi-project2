class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :data
      t.references :users, index: true, foreign_key: true
      t.references :tags, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
