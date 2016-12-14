class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :text
    add_column :users, :last_name, :text
    add_column :users, :birthdate, :date
    add_column :users, :phone_number, :text
    add_column :users, :gender, :text
    add_column :users, :country, :text
    add_column :users, :street, :text
    add_column :users, :postal_code, :text
  end
end
