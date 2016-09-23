require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
	  
	def setup
	  @club = clubs(:henrys)
	  @activity = @club.activities.build(name: "Qi Gung")
	end

	test "should be valid" do 
		assert @activity.valid?
	end

	test "club id should be present" do 
		@activity.club_id = nil
		assert_not @activity.valid?
	end

	test "name should be present" do
		@activity.name = "    "
		assert_not @activity.valid?
	end

	test "name should not exceed 50 characters" do
		@activity.name = "a" * 51
		assert_not @activity.valid?
	end

end
