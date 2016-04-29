class AddBreedItemToProfiles < ActiveRecord::Migration
  def change
    add_reference :profiles, :breed_item, index: true, foreign_key: true
  end
end
