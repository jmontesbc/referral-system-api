class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.text :requirements
      t.integer :grade
      t.string :client
      t.integer :num_positions
      t.float :referal_bonus
      t.boolean :active
      t.string :branch_refered_for
      t.integer :priority
      t.integer :bullhorn_id
      t.integer :modify_by

      t.timestamps
    end
  end
end
