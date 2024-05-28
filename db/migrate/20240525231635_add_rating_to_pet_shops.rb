class AddRatingToPetShops < ActiveRecord::Migration[7.1]
  def change
    add_column :pet_shops, :rating, :integer
  end
end
