class CreateReferrals < ActiveRecord::Migration[6.1]
  def change
    create_table :referrals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :given_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :linkedin_url
      t.string :cv_url

      t.timestamps
    end
  end
end
