class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :auction, index: true
      t.string :content, null: false

      t.timestamps null: false
    end
  end
end
