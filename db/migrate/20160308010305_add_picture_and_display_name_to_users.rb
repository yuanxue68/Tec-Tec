class AddPictureAndDisplayNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :picture, :string
    add_column :users, :display_name, :string
  
    User.reset_column_information

    User.all.each do |user|
      user.display_name = user.email
      user.save
    end

    change_column_null :users, :display_name, false
  end
end
