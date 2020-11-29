class Publication < ApplicationRecord
  validates :title, presence: true

  belongs_to :person
end
