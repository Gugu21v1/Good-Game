class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  validates :size, :name, :type, :description, :image_url, presence: true
end
