class Product < ApplicationRecord
  has_many :inters
  has_many_attached :photo

end
