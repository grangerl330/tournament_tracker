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

  def result
    if in_progress?
      "In Progress"
    elsif self.matches.all? {|match| match.won == true}
      self.update(won: true)
      "Won"
    else
      self.update(won: false)
      "Lost in #{@losing_match.round_num_or_name}"
    end
  end

  def losing_match
    @losing_match ||= self.matches.find {|match| match.won == false}
  end

  def in_progress?
    self.matches.size < self.round_options.size && !losing_match
  end
end
