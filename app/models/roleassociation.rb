class Roleassociation < ActiveRecord::Base
  belongs_to :person
  belongs_to :role
end