class Publication < ApplicationRecord
  validates :title, presence: true
end
