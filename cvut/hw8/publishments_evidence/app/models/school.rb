class School < ApplicationRecord
  has_many :persons

  validates :name, :code, presence: true
end
