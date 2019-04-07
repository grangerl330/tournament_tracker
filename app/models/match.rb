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

  def select_default_round
    case self.round
    when 2
      "Final"
    when 4
      "Semi-Final"
    when 8
      "Quarter-Final"
    else
      self.round
    end
  end

  def result
    if self.won
      "Won"
    else
      "Lost"
    end
  end

  def destroy_and_update_record
    # need to use helper methods here. would be great if I could have access to the update_user_record method currently in MatchesController
  end

  def add_to_user_record
    if self.won
      self.tournament.user.add_win
    else
      self.tournament.user.add_loss
    end
  end

  def remove_from_user_record
    if self.won
      self.tournament.user.remove_win
    else
      self.tournament.user.remove_loss
    end
  end

  def update_user_record
    if self.won
      self.tournament.user.add_win
      self.tournament.user.remove_loss
    else
      self.tournament.user.add_loss
      self.tournament.user.remove_win
    end
  end
end
