class AddIdToFriendshipColumnNames < ActiveRecord::Migration
  def change
    rename_column :friendships, :first_person, :first_person_id
    rename_column :friendships, :second_person, :second_person_id
  end
end
