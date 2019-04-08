class Tournament < ApplicationRecord
  belongs_to :user
  has_many :matches

  def round_options
    starting_round = self.draw_size
  
    if starting_round == nil || starting_round == 256
      [256, 128, 64, 32, 16, 8, 4, 2]
    elsif starting_round == 128
      [128, 64, 32, 16, 8, 4, 2]
    elsif starting_round == 64
      [64, 32, 16, 8, 4, 2]
    elsif starting_round == 32
      [32, 16, 8, 4, 2]
    elsif starting_round == 16
      [16, 8, 4, 2]
    elsif starting_round == 8
      [8, 4, 2]
    elsif starting_round == 4
      [4, 2]
    elsif starting_round == 2
      [2]
    end
  end
end
