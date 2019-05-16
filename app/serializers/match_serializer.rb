class MatchSerializer < ActiveModel::Serializer
  attributes :id, :score, :won, :date, :time, :tournament_id
  belongs_to :tournament
end
