class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date
      t.references :location, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
  end
end
