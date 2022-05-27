class User < ApplicationRecord
  has_many :permissions
  has_many :referrals
  has_many :positions_referrals_histories
  belongs_to :role

  validates :role, :name, presence: true
end
