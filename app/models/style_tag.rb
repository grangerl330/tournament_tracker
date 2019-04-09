class StyleTag < ApplicationRecord
  has_many :opponent_style_tags
  has_many :opponents, through: :opponent_style_tags
end
