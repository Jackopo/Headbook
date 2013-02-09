class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :admin, 
                  :bio, :gender ,:hometown, :current_city, :dob, :work, :employer, :education, :avatar
  has_many :posts, dependent: :destroy
  validates_presence_of :name
  
  has_attached_file :avatar, 
    :storage => :dropbox,
    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
    :styles => { :medium => "400x300>", :thumb => "200x150>" },
    :dropbox_options => {
      :path => proc { |style| "/HeadBook/#{Rails.env}/#{style}/#{id}_#{avatar.original_filename}" }     
    }

  def befriended?(other_user)
    
    if (Friendship.find_by_first_person_id_and_second_person_id(self.id, other_user.id) || 
      Friendship.find_by_first_person_id_and_second_person_id(other_user.id, self.id) )
      true
    else
      false
    end

  end
  
  # Search function - it searches for equal names and emails
  def self.search(search)
    if search
      where("name LIKE ? OR email LIKE ?", "%#{search}%", search)
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
   
   def getFriends 

      friends = Array.new

      friendships.each {
        |friendship| friends << User.find(friendship.second_person_id)
      }

      reverse_friendships.each {
        |friendship| friends << User.find(friendship.first_person_id)
      }

      friends

   end  
   
end
