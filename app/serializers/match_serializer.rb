class MatchSerializer < ActiveModel::Serializer
  attributes :id, :score, :won, :date, :time, :tournament_id, :round
  belongs_to :tournament
  has_one :opponent
end
