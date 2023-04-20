class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  validates :name, presence: true
  validates :details, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { only_integer: true }
  validates :address, presence: true
  validates :user_id, presence: true

  has_one_attached :room_image
end
