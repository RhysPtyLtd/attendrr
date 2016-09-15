class Club < ApplicationRecord
	attr_accessor :remember_token
	before_save { email.downcase! }
    before_save { state.upcase! }
    #before_save { owner_first_name.capitalize_name }
    #before_save { owner_last_name.capitalize_name }
	validates :name, presence: true, length: { maximum: 50 } 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
					  length: { maximum: 255 }, 
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    validates :address_line_1, presence: true, length: { maximum: 200 }
    validates :city, presence: true, length: { maximum: 200 }
    validates :state, presence: true, length: { maximum: 200 }
    validates :postcode, presence: true
    validates :country, presence: true, length: { maximum: 200 }
    validates :phone1, presence: true, length: { maximum: 25, minimum: 8 }
    validates :owner_first_name, presence: true, length: { maximum: 200 }
    validates :owner_last_name, presence: true, length: { maximum: 200 }

	# Returns the hash digest of the given string. This is a CLASS METHOD.
	def Club.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token
    def Club.new_token
    	SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in persistent sessions
    def remember
    	self.remember_token = Club.new_token
    	update_attribute(:remember_digest, Club.digest(remember_token))
    end

    # Returns true if the given token matches the digest
    def authenticated?(remember_token)
    	return false if remember_digest.nil?
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forgets a club
    def forget
    	update_attribute(:remember_digest, nil)
    end

end