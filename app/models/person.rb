class Person < ActiveRecord::Base
  validates :firstname, :lastname, presence: true
end
