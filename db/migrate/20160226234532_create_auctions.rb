class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name, null: false
      t.text :description
      t.string :course_code
      t.string :school
      t.float :starting_price, default: 0.00
      t.float :buyout_price
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :owner_id, index: true
      t.integer :winner_id, index: true

      t.timestamps null: false
    end
    add_index :auctions, [:owner_id, :end_time]
    add_index :auctions, :end_time
    add_foreign_key :auctions, :users, column: :winner_id 
    add_foreign_key :auctions, :users, column: :owner_id
  end
end
