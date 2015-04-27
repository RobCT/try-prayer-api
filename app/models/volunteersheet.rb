class Volunteersheet < ActiveRecord::Base
  validates :about, :rowindex, presence: true
  belongs_to :role
  belongs_to :person
  belongs_to :event
end
