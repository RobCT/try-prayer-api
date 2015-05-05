class Person < ActiveRecord::Base
  has_and_belongs_to_many :roles, autosave: true
  validates :firstname, :lastname, presence: true
  has_one :volunteersheet
  belongs_to :user
end
