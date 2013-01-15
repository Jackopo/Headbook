class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :name
  has_many :posts, dependent: :destroy
  validates_presence_of :name
  
  def befriended?(other_user)
    friendships.find_by_second_person_id(other_user.id)
  end

  def befriend!(other_user)
    friendships.create!(first_person_id: other_user.id)
  end
    
  def unfriend!(other_user)
    friendships.find_by_second_person_id(other_user.id).destroy
  end
  
  # Search function - it searches for equal names and emails
  def self.search(search)
    if search
      where("name LIKE ? OR email LIKE ?", search, search)
    else
      all
  end
  
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
