require 'test_helper'

class ClubsSignupTest < ActionDispatch::IntegrationTest
  
	test "invalid signup information" do 
		get signup_path
		assert_no_difference 'Club.count' do
			post clubs_path, params: { club: { name: "",
											   email: "club@invalid",
											   password: "foo",
											   password_confirmation: "bar" } }
		end
		assert_template 'clubs/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger'
	end

	test "valid signup information" do 
		get signup_path
		assert_difference 'Club.count', 1 do
			post clubs_path, params: { club: { name: "Example Club",
				                               email: "club@example.com",
				                               password: "password",
				                               password_confirmation: "password" } }
		end
		follow_redirect!
		assert_template 'clubs/show'
		assert_not flash.empty?
	end

end
