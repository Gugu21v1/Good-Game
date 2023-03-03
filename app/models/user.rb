class User < ApplicationRecord
  # Include default devise modules. Others available are:
  has_many :products, dependent: :destroy

  has_one_attached :user_url
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
