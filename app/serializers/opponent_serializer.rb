class OpponentSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :age, :handedness, :match_id
  belongs_to :match
end
