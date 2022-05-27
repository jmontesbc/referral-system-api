class Role < ApplicationRecord
  has_many :users

  validates :type, presence: true
end
