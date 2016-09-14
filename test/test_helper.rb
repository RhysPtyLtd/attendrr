ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # Returns true if a test club is logged in
  def is_logged_in?
  	!session[:club_id].nil?
  end

  # Log in as a particular club
  def log_in_as(club)
  	session[:club_id] = club.id
  end
end

class ActionDispatch::IntegrationTest

	# Log in as a particular club
	def log_in_as(user, password: 'password', remember_me: '1')
		post login_path, params: { session: { email: user.email,
											  password: password,
											  remember_me: remember_me } }
	end
  
end