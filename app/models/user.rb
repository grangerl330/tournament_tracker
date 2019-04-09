class User < ApplicationRecord
  has_many :tournaments
  has_many :matches, through: :tournaments
  has_many :opponents, through: :matches

  has_secure_password

  validates :email, uniqueness: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def overall_record
    wins = 0
    losses = 0
    self.matches.each do |match|
      if match.won
        wins += 1
      else
        losses += 1
      end
    end
    "#{wins} - #{losses}"
  end

end
