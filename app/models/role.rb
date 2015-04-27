class Role < ActiveRecord::Base
  has_and_belongs_to_many :people, autosave: true
  validates :description,  presence: true
  has_one :volunteersheet
end
