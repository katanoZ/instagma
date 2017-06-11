class Picture < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
