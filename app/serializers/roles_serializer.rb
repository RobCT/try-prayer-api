class RolesSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_and_belongs_to_many :people
end
