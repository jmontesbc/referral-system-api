class CreatePositionsReferrals < ActiveRecord::Migration[6.1]
  def change
    create_table :positions_referrals do |t|
      t.references :referral, null: false, foreign_key: true
      t.timestamp :signed_date

      t.timestamps
    end
  end
end
