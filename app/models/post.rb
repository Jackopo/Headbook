class Post < ActiveRecord::Base
  attr_accessible :content,:user_id
  belongs_to :user

  validates :user_id, :presence => true
  validates :content, :presence => true, :length => { :minimum => 1}
  default_scope order: 'posts.created_at DESC'
end
