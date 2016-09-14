require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

	def setup
		@club = clubs(:michael)
		remember(@club)
	end

	test "current_club returns right club when session is nil" do 
		assert_equal @club, current_club
		assert is_logged_in?
	end

	test "current_club returns nil when remember_digest is wrong" do
		@club.update_attribute(:remember_digest, Club.digest(Club.new_token))
		assert_nil current_club
	end
end