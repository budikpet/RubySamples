class Person < ApplicationRecord
  belongs_to :school
  has_many :publications
  
  validates :full_name, :email, :username, presence: true
end
