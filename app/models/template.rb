class Template < ActiveRecord::Base
  validates :title,  presence: true
  has_many :volunteersheets, dependent: :destroy
end
