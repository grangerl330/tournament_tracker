class Tournament < ApplicationRecord
  belongs_to :user
  has_many :matches

  def points_gained?
    self.points != 0
  end

  def round_options
    starting_round = self.draw_size

    if starting_round == nil || starting_round == 256
      [256, 128, 64, 32, 16, "Quarter-Final", "Semi-Final", "Final"]
    elsif starting_round == 128
      [128, 64, 32, 16, "Quarter-Final", "Semi-Final", "Final"]
    elsif starting_round == 64
      [64, 32, 16, "Quarter-Final", "Semi-Final", "Final"]
    elsif starting_round == 32
      [32, 16, "Quarter-Final", "Semi-Final", 'Final']
    elsif starting_round == 16
      [16, "Quarter-Final", "Semi-Final", "Final"]
    elsif starting_round == 8
      ["Quarter-Final", "Semi-Final", "Final"]
    elsif starting_round == 4
      ["Semi-Final", "Final"]
    elsif starting_round == 2
      ["Final"]
    end
  end
end
