class EventsSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :eventdate, :eventstart, :eventend, :title
  has_many :volunteersheets
end
