class UserSerializer < ActiveModel::Serializer
  
  attributes :id, :email, :username,  :created_at, :updated_at, :auth_token
  
end
