require 'test_helper'

class ClubsEditTest < ActionDispatch::IntegrationTest
  
	def setup
		@club = clubs(:kapow)
	end

	test "unsuccessful edit" do
		log_in_as(@club)
		get edit_club_path(@club)
		assert_template 'clubs/edit'
		patch club_path(@club), params: { club: { name: "",
		                                          email: "foo@invalid",
		                                          password: "foo",
		                                          password_confirmation: "bar" } }
		assert_template 'clubs/edit'
		assert_select 'div.alert'
	end

	test "successful edit" do 
		log_in_as(@club)
		get edit_club_path(@club)                              
		assert_template 'clubs/edit'
		name = "Foo Bar"
		email = "foo@bar.com"
		patch club_path(@club), params: { club: { name: name,
										  		  email: email,
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
		assert_not flash.empty?
		assert_redirected_to @club
		@club.reload
		assert_equal name, @club.name
		assert_equal email, @club.email
	end

	test "successful edit with friendly forwarding" do
		get edit_club_path(@club)
		log_in_as(@club)
		assert_redirected_to edit_club_path(@club)
		name = "Foo Bar"
		email = "foo@bar.com"
		patch club_path(@club), params: { club: { name: name,
												  email: email,
												  password: "",
												  password_confirmation: "",
			             					      address_line_1: "123 Street St.", 
			             					      city: "Hometown",
			             						  state: "VIC", 
			             						  postcode: 1234, 
			             						  country: "Turkmenistan", 
			             						  phone1: "985764345",
			             						  owner_first_name: "Greg", 
			             						  owner_last_name: "Egg" } }
		assert_not flash.empty?
		assert_redirected_to @club
		@club.reload
		assert_equal name, @club.name
		assert_equal email, @club.email
	end

end