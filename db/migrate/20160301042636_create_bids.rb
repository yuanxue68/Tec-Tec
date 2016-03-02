class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user, index: true
      t.references :auction, index: true
      t.float :bid_amount, null: false

      t.timestamps null: false
    end

    add_index :bids, [:created_at]
  end
end
