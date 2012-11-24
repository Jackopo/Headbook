class User < ActiveRecord::Base
  attr_accessible :email, :name
  
  
  
  def befriended?(other_user)
    relationships.find_by_second_person_id(other_user.id)
  end

  def befriend!(other_user)
    following << other_user
    #relationships.create!(followed_id: other_user.id)
  end
    
  def unfriend!(other_user)
    following.delete(other_user)
    #relationships.find_by_followed_id(other_user.id).destroy
  end
  
   #
   # M zu M Beziehung
   # User <-mc------ friendships ------mc-> User
   has_many :friends, through: :friendships, source: :second_person, dependent: :destroy
   
   
   
   
end
