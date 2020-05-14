class Subscription < ApplicationRecord
	has_many :clubs
	default_scope -> { order(:student_limit) }
end
