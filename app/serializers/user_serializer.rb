class UserSerializer < ActiveModel::Serializer
  
  attributes :id, :email, :username, :firstname, :lastname, :created_at, :updated_at, :auth_token
  
end
