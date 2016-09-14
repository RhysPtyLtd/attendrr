require 'test_helper'

class ClubsControllerTest < ActionDispatch::IntegrationTest

	def setup
		@club = clubs(:michael)
		@other_club = clubs(:archer)
	end

  test "should redirect index when not logged in" do # Change to redirect index when not admin
    get clubs_path
    assert_redirected_to login_url
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
  	get edit_club_path(@club)
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
  	patch club_path(@club), params: { club: { name: @club.name,
  											  email: @club.email } }
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_club)
    assert_not @other_club.admin?
    patch club_path(@other_club), params: { club: { admin: true } }
    assert_not @other_club.reload.admin?
  end

  test "should redirect edit when logged in as wrong club" do 
  	log_in_as(@other_club)
  	get edit_club_path(@club)
  	assert flash.empty?
  	assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong club" do 
  	log_in_as(@other_club)
  	patch club_path(@club), params: { club: { name: @club.name,
  									          email: @club.email } }
	assert flash.empty?
	assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as non-admin" do
    log_in_as(@other_club)
    assert_no_difference 'Club.count' do
      delete club_path(@club)
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Club.count' do 
      delete club_path(@club)
    end
    assert_redirected_to login_url
  end

end