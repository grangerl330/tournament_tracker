class User < ApplicationRecord
  has_many :tournaments
  has_many :matches, through: :tournaments
  has_many :opponents, through: :matches

  has_secure_password #validations: false  #-> added this to get facebook omniauth to work the first time logging in when it had to create a new user

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

  def convert_facebook_name
    first_name = self.name.split.first
    last_name = self.name.split.last
    self.update(first_name: first_name, last_name: last_name)
  end

  def record_vs(opponent)
    opponent_matches = self.matches.select {|match| match.opponent = opponent}
    wins = opponent_matches.select {|match| match.won = true}
    losses = opponent_matches.select {|match| match.won = false}
    "#{wins.count} - #{losses.count}"
  end
end
