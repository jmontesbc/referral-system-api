class CreatePositionReferralStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :position_referral_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
