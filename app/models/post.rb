class Post < ActiveRecord::Base
  attr_accessible :content,:user_id, :image
  belongs_to :user

  validates :user_id, :presence => true
  validates :content, :presence => true, :length => { :minimum => 1}
  # substitute ASC with DESC if we want a descending order
  default_scope order: 'posts.created_at DESC'

  has_attached_file :image, 
  	:storage => :dropbox,
    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
    :styles => { :medium => "600x400>", :thumb => "200x150>" },
    :dropbox_options => {
      :path => proc { |style| "/HeadBook/#{Rails.env}/#{style}/#{id}_#{image.original_filename}" }     
    }

end
