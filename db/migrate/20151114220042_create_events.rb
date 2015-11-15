class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :when
      t.belongs_to :location

      t.timestamps null: false
    end
  end
end
