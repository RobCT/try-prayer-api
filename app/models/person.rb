class Person < ActiveRecord::Base
  has_and_belongs_to_many :roles, autosave: true
  validates :firstname, :lastname, presence: true
end
