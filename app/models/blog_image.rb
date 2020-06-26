class BlogImage < ApplicationRecord
	mount_uploader :image_data, BlogUploader
end
