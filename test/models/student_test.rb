require 'test_helper'

class StudentTest < ActiveSupport::TestCase
	 
	def setup
	  @club = clubs(:kapow)
	  @student = @club.students.build(first_name: "Grinkler", 
	  						 club_id: @club.id,
	  						 last_name: "Nash",
	  						 email: "grink@thesink.com",
	  						 address_line_1: "10 Street St.",
	  						 city: "Hometown",
	  						 postcode: 1234,
	  						 state: "ACT",
	  						 phone1: "0596878543",
	  						 dob: Date.new(1990, 10, 26))
	end

	test "should be valid" do 
		assert @student.valid?
	end

	test "club id should be present" do 
		@student.club_id = nil
		assert_not @student.valid?
	end

	test "required fields should be present" do
		@student.first_name = "   "
		@student.last_name = "   "
		@student.email = "   "
		@student.address_line_1 = "   "
		@student.city = "   "
		@student.state = "   "
		@student.postcode = "   "
		@student.phone1 = "   "
		@student.dob = "   "
		assert_not @student.valid?
	end


end
