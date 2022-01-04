class Spectacle < ApplicationRecord
  validates :name, :period, presence: true
  validate ->(s) { errors.add(:period, "Spectacle exists.") if Spectacle.from_range(s.period).present? }

  def self.from_range(range)
    return unless range&.sort.present?
    where("period && :range::daterange", range: "[#{range.first},#{range.last}]")
  end
end
