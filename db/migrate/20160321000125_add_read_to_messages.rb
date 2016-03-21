class AddReadToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :read, :string, default: false
  end
end
