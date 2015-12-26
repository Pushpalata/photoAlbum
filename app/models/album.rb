class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates_presence_of :title
  accepts_nested_attributes_for :photos, :allow_destroy => true

  validate :validate_max_photos

  def validate_max_photos
    errors.add(:base ,"You cannot have more than 25 photos in Album.") if photos.size > 25
  end

  

end
