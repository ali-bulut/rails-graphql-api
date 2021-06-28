class Types::CoordinatesType < Types::BaseObject
  field :latitude, Float, null: true
  field :longitude, Float, null: true

  def latitude
    object.first
  end

  def longitude
    object.last
  end

  # we can also use like that. Only allow greater then 10 for the first element, and lower than 10 for the last element.
  # If it is not the case, then raise unauthorized error.
  def self.authorized?(object, context)
    object.first > 10 && object.last < 10
  end
end