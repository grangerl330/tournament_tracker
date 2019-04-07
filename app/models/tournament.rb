class Tournament < ApplicationRecord
  belongs_to :user
  has_many :matches

  def points_gained?
    self.points != 0
  end

  def round_options_numbers
    options = [256, 128, 64, 32, 16, 8, 4, 2]
    starting_round = options.index(self.draw_size)

    options[starting_round..-1]
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

  def round_options
    @options = self.round_options_numbers
    self.matches.each do |match|
      if @options.include?(match.round)
        @options -= [match.round]
      end
    end
    convert_round_options
  end

  def result
    if in_progress?
      "In Progress"
    elsif self.matches.all? {|match| match.won == true}
      self.update(won: true)
      "Won"
    else
      self.update(won: false)
      "Lost in #{losing_match.round_num_or_name}"
    end
  end

  def losing_match
    losing_match ||= self.matches.find {|match| match.won == false}
  end

  def in_progress?
    self.matches.size < self.round_options.size && !losing_match
  end

  def add_points_to_user
    self.user.points += self.points
    self.user.save
  end

  def remove_points_from_user
    self.user.points -= self.points
    self.user.save
  end

  def update_user_points
    if self.points_gained?
      add_points_to_user
    end
  end

  def destroy_all_matches
    self.matches.each do |match|
      match.remove_from_user_record
      match.destroy
    end
  end
end
