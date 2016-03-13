class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content, null: false
      t.integer :giver_id, index: true
      t.integer :receiver_id, index: true
      t.timestamps null:false
    end

    add_foreign_key :reviews, :users, column: :giver_id
    add_foreign_key :reviews, :users, column: :receiver_id
  end
end
