class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag
      t.references :taggings, index: true, foreign_key: true
      t.references :events, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
