class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hometown, :string
    add_column :users, :current_city, :string
    add_column :users, :dob, :date
    add_column :users, :work, :string
    add_column :users, :employer, :string
    add_column :users, :education, :string
  end
end
