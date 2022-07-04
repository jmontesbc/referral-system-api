class Referral < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'referred_by'

  validates :linkedin_url, uniqueness: { scope: :full_name, case_sensitive: false, message: 'The combination of full name and linkedin url is already taken' }
  validates :email, uniqueness: { case_sensitive: false, message: 'The email is already taken' }
  validates :phone_number, uniqueness: { message: 'The phone number is already taken' }
end
