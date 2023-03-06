class Product < ApplicationRecord
  has_many_attached :product_url

  validates :product_url, presence: true
end
