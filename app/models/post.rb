class Post < ActiveRecord::Base
	mount_uploader :image, AvatarUploader
	validates  :title, 			  presence: true#, uniqueness: true
	validates  :description,  presence: true
	validates  :content,      presence: true
	validates  :user_id,			presence: true
	belongs_to :user
	has_many 	 :comments, 		dependent: :destroy
	self.per_page = 5

	def self.search(search)
		if search
			where('title LIKE?', "%#{search}%")
		else
			all
		end
	end
end
