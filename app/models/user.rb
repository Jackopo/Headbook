class User < ActiveRecord::Base
  attr_accessible :email, :name
  
  
  
  def befriended?(other_user)
    friendships.find_by_second_person_id(other_user.id)
  end

  def befriend!(other_user)
    friendships.create!(first_person_id: other_user.id)
  end
    
  def unfriend!(other_user)
    friendships.find_by_second_person_id(other_user.id).destroy
  end
  
   #
   # M zu M Beziehung
   # User <-mc------ friendships ------mc-> User
   
   #has_many :friendships, :foreign_key => "first_person_id", :dependent => :destroy
   #has_many :friends, :through => :friendships, :class_name => "User"
   #has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "second_person_id"
  # has_many :inverse_friends, :through => :inverse_friendships, :source => :user
   
   has_many :friendships, :foreign_key => "first_person_id" , :dependent => :destroy
   has_many :reverse_friendships, :foreign_key => "second_person_id", :class_name => "Friendship", :dependent => :destroy
   
   
   
   
   
end
