class Opponent < ApplicationRecord
  belongs_to :match
  has_many :opponent_style_tags, dependent: :nullify
  has_many :style_tags, through: :opponent_style_tags

  def style_tags_attributes=(style_tags_hashes)
    style_tags_hashes.each do |i, style_tag_attributes|
      if style_tag_attributes[:name].present?
        style_tag = StyleTag.find_or_create_by(name: style_tag_attributes[:name])
        if !self.style_tags.include?(style_tag)
          self.opponent_style_tags.build(style_tag: style_tag)
        end
      end
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
