require 'test_helper'

class ClubTest < ActiveSupport::TestCase
  
	def setup
		@club = Club.new(name: "Example Club", email: "club@example.com", password: "password", 
			             password_confirmation: "password")
	end

	test "should be valid" do 
		assert @club.valid?
	end

	test "name should be present" do 
		@club.name = "   "
		assert_not @club.valid?
	end

	test "email should be present" do 
		@club.email = "   "
		assert_not @club.valid?
	end

	test "name should not be too long" do
		@club.name = "a" * 51
		assert_not @club.valid?
	end

	test "email should not be too long" do
		@club.email = "a" * 244 + "@example.com"
		assert_not @club.valid?
	end

	test "email validation should accept valid addresses" do
		valid_addresses = %w[club@example.com CLUB@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    	valid_addresses.each do |valid_address|
        	@club.email = valid_address
        	assert @club.valid?, "#{valid_address.inspect} should be valid" # Second argument is custom error message that identifies address that caused test to fail. 
    	end
  	end

  	test "email validation should reject invalid addresses" do
    	invalid_addresses = %w[club@example,com user_at_foo.org foo@bar..com club.name@example. foo@bar_baz.com foo@bar+baz.com]
    	invalid_addresses.each do |invalid_address|
    		@club.email = invalid_address
    		assert_not @club.valid?, "#{invalid_address.inspect} should be invalid"
    	end
  	end

  	test "email addresses should be unique" do
  		duplicate_club = @club.dup
  		duplicate_club.email = @club.email.upcase
  		@club.save
  		assert_not duplicate_club.valid?
  	end

  	test "email addresses should be saved as lowercase" do
  		mixed_case_email = "Foo@BaR.CoM"
  		@club.email = mixed_case_email
  		@club.save
  		assert_equal mixed_case_email.downcase, @club.reload.email
  	end

  	test "password should be present (nonblank)" do 
  		@club.password = @club.password_confirmation = " " * 6
  		assert_not @club.valid?
  	end

  	test "password should have a minimum length" do 
  		@club.password = @club.password_confirmation = "a" * 5
  		assert_not @club.valid?
  	end

end