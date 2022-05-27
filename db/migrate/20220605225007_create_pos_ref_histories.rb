class CreatePosRefHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :pos_ref_histories do |t|
      t.references :positions_referral, null: false, foreign_key: true
      t.references :position_referral_status, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
