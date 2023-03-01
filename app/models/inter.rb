class Inter < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :product, uniqueness: { scope: :user }
end
