class Post < ActiveRecord::Base
  attr_accessible :content,:user_id
  belongs_to :user

  validates :user_id, :presence => true
  validates :content, :presence => true, :length => { :minimum => 1}
  # substitute ASC with DESC if we want a descending order
  default_scope order: 'posts.created_at ASC'
end
