class School < ApplicationRecord
  validate :name, :code, presence: true
end
