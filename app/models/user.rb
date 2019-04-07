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
    "#{self.match_wins} - #{self.match_losses}"
  end

  def add_win
    self.match_wins += 1
    self.save
  end

  def add_loss
    self.match_losses += 1
    self.save
  end

  def remove_win
    self.match_wins -= 1
    self.save
  end

  def remove_loss
    self.match_losses -= 1
    self.save
  end

end
