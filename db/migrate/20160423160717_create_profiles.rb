class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name,   null: false
      t.string :gender, null: false
      t.date :dob,      null: false
      t.text :body

      t.timestamps null: false
    end
  end
end
