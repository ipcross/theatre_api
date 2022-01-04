class SpectacleSerializer < ActiveModel::Serializer
  type 'spectacles'
  attributes :id, :name, :date_from, :date_to

  def date_from
    object.period.first
  end

  def date_to
    object.period.last
  end
end
