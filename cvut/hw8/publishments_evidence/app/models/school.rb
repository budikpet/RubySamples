class School < ApplicationRecord
  validates :name, :code, presence: true

  has_many :people
end
