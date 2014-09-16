class Post < ActiveRecord::Base
	mount_uploader :image, AvatarUploader
	validates :title, 			presence: true, uniqueness: true
	validates :description, presence: true
	validates :content,     presence: true
	validates :user_id,			presence: true
	belongs_to :user
	self.per_page = 5
end
