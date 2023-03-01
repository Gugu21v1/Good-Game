class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :size, :name, :type, :description, :image_url, presence: true
end
