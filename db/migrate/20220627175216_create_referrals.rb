class CreateReferrals < ActiveRecord::Migration[6.1]
  def change
    create_table :referrals do |t|
      t.integer :referred_by
      t.string :full_name
      t.string :phone_number
      t.string :email
      t.string :linkedin_url
      t.string :cv_url
      t.text :tech_stack
      t.integer :ta_recruiter
      t.integer :status
      t.text :comments
      t.date :signed_date

      t.timestamps
    end
  end
end
