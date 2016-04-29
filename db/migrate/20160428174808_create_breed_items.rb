class CreateBreedItems < ActiveRecord::Migration
  def change
    create_table :breed_items do |t|
      t.string :name, null: false
      t.references :breed_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
