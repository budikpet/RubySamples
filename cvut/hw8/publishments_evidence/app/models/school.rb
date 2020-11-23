class School < ApplicationRecord
  validates :name, :code, presence: true
end
