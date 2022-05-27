class PosRefHistory < ApplicationRecord
  belongs_to :positions_referral
  belongs_to :position_referral_status
  belongs_to :user
end
