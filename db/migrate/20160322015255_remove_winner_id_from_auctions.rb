class RemoveWinnerIdFromAuctions < ActiveRecord::Migration
  def change
    remove_column :auctions, :winner_id
    add_column :auctions, :brought_out, :string, default: false
  end
end
