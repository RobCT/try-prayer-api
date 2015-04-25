class EventsSerializer < ActiveModel::Serializer
  attributes :id, :eventdate, :eventstart, :eventend, :title
end
