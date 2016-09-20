require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  
	def setup
		@student = students(:bob)
	end

	test "Should redirect create when not logged in" do
		assert_no_difference 'Student.count' do
			post students_path, params: { student: {first_name: "Xavier",
								                    last_name: "Professor",
								                    address_line_1: "123 Avenue Ave.",
								                    city: "Philly",
								                    state: "NY",
								                    postcode: 2345,
								                    phone1: "0596895473",
								                    dob: 1950-8-18,
								                    email: "xavier@giftedyoungsters.com" } }
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when not logged in" do 
		assert_no_difference 'Student.count' do 
			delete student_path(@student)
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when logged in as wrong club" do
		log_in_as(clubs(:henrys))
		student = students(:bob)
		assert_no_difference 'Student.count' do
			delete student_path(student)
		end
		assert_redirected_to root_url
	end

end