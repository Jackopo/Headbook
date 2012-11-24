class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :first_person
      t.integer :second_person

      t.timestamps
    end
  end
end
