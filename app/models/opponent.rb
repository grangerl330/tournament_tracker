class Opponent < ApplicationRecord
  belongs_to :match
  has_many :opponent_style_tags, dependent: :nullify
  has_many :style_tags, through: :opponent_style_tags

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
