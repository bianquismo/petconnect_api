class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.timestamp :time
      t.references :user, null: false, foreign_key: true
      t.references :pet_shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
