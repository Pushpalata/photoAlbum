class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :album

  validates_presence_of :title

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  

  
end
