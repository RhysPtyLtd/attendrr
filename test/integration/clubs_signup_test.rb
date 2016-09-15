require 'test_helper'

class ClubsSignupTest < ActionDispatch::IntegrationTest
  
	test "invalid signup information" do 
		get signup_path
		assert_no_difference 'Club.count' do
			post clubs_path, params: { club: { name: "",
											   email: "club@invalid",
											   password: "foo",
											   password_confirmation: "bar",
		             						   address_line_1: "123 Street St.", 
		             						   city: "Hometown",
		             						   state: "VIC", 
		             						   postcode: 1234, 
		             						   country: "Turkmenistan", 
		             						   phone1: "985764345",
		             						   owner_first_name: "Greg", 
		             						   owner_last_name: "Egg" } }
		end
		assert_template 'clubs/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger'
	end

	test "valid signup information" do 
		get signup_path
		assert_difference 'Club.count', 1 do
			post clubs_path, params: { club: { name: "Bob's Fight Club",
											   email: "club@valid.com",
											   password: "password",
											   password_confirmation: "password",
		             						   address_line_1: "123 Street St.", 
		             						   city: "Hometown",
		             						   state: "VIC", 
		             						   postcode: 1234, 
		             						   country: "Turkmenistan", 
		             						   phone1: "985764345",
		             						   owner_first_name: "Greg", 
		             						   owner_last_name: "Egg" } }
		end
		follow_redirect!
		assert_template 'clubs/show'
		assert_not flash.empty?
		assert is_logged_in? # is_logged_in? comes from the test/test_helper.rb file
	end

end
