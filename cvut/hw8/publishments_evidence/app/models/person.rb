class Person < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /.+@.+\..+/, message: 'invalid' }

  belongs_to :school
  has_many :publications
end
