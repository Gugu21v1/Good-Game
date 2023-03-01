class User < ApplicationRecord
  # Include default devise modules. Others available are:
  has_many :inters, dependent: :destroy
  has_many :products, through: :inters

  has_one_attached :user_url
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
