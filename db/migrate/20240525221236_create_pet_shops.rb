class CreatePetShops < ActiveRecord::Migration[7.1]
  def change
    create_table :pet_shops do |t|
      t.string :name
      t.string :address
      t.string :open_hours
      t.string :phone_number

      t.timestamps
    end
  end
end
