class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :location, :draw_size, :points, :won, :user_id
  belongs_to :user
  has_many :matches
end
