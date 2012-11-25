class Friendship < ActiveRecord::Base
  attr_accessible :first_person_id, :second_person_id
  
  belongs_to :first_person, class_name: "User"
  belongs_to :second_person, class_name: "User"
  
  validates :first_person_id, presence: true
  validates :second_person_id, presence: true
  
end
