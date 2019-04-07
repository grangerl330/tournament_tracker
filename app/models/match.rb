class Match < ApplicationRecord
  belongs_to :tournament
  has_one :opponent
  accepts_nested_attributes_for :opponent

  def round_options
    options = [256, 128, 64, 32, 16, 8, 4, 2]
    start_point = options.index(self.round)
    @options = options[start_point..-1]
    convert_round_options
    @options
  end

  def convert_round_options
    @options.map! do |option|
      if option == 8
        "Quarter-Final"
      elsif option == 4
        "Semi-Final"
      elsif option == 2
        "Final"
      else
        option
      end
    end
    @options
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
