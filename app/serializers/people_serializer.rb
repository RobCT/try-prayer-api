class PeopleSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :firstname, :lastname, :auth_token
  has_and_belongs_to_many :roles
end
