class Person < ApplicationRecord
  validates :full_name, :email, :username, presence: true
end
