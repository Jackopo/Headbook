class Friendship < ActiveRecord::Base
  attr_accessible :first_person, :second_person
  
  belongs_to :first_person, class_name: "User"
  belongs_to :second_person, class_name: "User"
  
  validates :first_person, presence: true
  validates :second_person, presence: true
  
end
