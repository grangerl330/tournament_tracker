class Match < ApplicationRecord
  belongs_to :tournament
  has_one :opponent
end
