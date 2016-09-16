require 'test_helper'

class ClubsSignupTest < ActionDispatch::IntegrationTest

	def setup
		ActionMailer::Base.deliveries.clear
	end
  
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

	test "valid signup information with account activation" do 
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
		assert_equal 1, ActionMailer::Base.deliveries.size
		club = assigns(:club)
		assert_not club.activated?
		# Try to log in before activation
		log_in_as(club)
		assert_not is_logged_in?
		# Invalid activation token
		get edit_account_activation_path("invalid token", email: club.email)
		assert_not is_logged_in?
		# Valid token, wrong email
		get edit_account_activation_path(club.activation_token, email: "wrong")
		assert_not is_logged_in?
		# Valid activation token
		get edit_account_activation_path(club.activation_token, email: club.email)
		assert club.reload.activated?
		follow_redirect!
		assert_template 'clubs/show'
		assert is_logged_in? # is_logged_in? comes from the test/test_helper.rb file
	end

end
