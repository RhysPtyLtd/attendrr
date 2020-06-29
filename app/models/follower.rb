class Follower < ApplicationRecord
	validates :name, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, 
            length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX }            
	before_save :downcase_email
	before_save :pretty_name

	def downcase_email
		self.email = self.email.downcase
	end

	def pretty_name
		self.name = self.name.downcase.titleize
	end

end

