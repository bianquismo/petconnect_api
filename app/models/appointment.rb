class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :pet_shop

  validates :time, presence: true
  validates :user_id, presence: true
  validates :pet_shop_id, presence: true
end
