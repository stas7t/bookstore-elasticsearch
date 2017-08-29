class Book < ApplicationRecord
  has_many :authors
  has_many :reviews
end
