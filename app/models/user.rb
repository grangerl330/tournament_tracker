class User < ApplicationRecord
  has_many :tournaments
  has_many :matches, through: :tournaments
  has_many :opponents, through: :matches

  has_secure_password
end
