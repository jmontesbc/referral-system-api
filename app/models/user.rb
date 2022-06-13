class User < ApplicationRecord
  has_many :permissions
  has_many :referrals
  has_many :positions_referrals_histories
  belongs_to :role

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
