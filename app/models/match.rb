class Match < ApplicationRecord
  belongs_to :tournament
  has_one :opponent
  accepts_nested_attributes_for :opponent

  def round_options
    if self.tournament
      starting_round = self.tournament.draw_size
    end

    if starting_round = nil || starting_round = 256
      [256, 128, 64, 32, 16, 8, 4, 2]
    elsif starting_round = 128
      [128, 64, 32, 16, 8, 4, 2]
    elsif starting_round = 64
      [64, 32, 16, 8, 4, 2]
    elsif starting_round = 32
      [32, 16, 8, 4, 2]
    elsif starting_round = 16
      [16, 8, 4, 2]
    elsif starting_round = 8
      [8, 4, 2]
    elsif starting_round = 4
      [4, 2]
    elsif starting_round = 2
      [2]
    end
  end

  def round_num_or_name
    case self.round
    when 2
      "Final"
    when 4
      "Semi-Final"
    when 8
      "Quarter-Final"
    else
      "Round of #{self.round}"
    end
  end

  def result
    if self.won
      "Won"
    else
      "Lost"
    end 
  end
end
