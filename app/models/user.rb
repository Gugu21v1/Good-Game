class User < ApplicationRecord
  has_many :inter, dependent: :destroy
  has_many :products, through: :inter

  validates :name, :phone, :email, presence: true
end
