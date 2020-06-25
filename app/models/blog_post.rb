class BlogPost < ApplicationRecord
	mount_uploader :picture, BlogUploader
	validates :title, presence: true
	validates :content, presence: true

end
