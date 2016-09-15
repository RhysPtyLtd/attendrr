require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

    def setup 
        @club = clubs(:henrys)
        @admin = clubs(:kapow)
    end

  test "layout links without login" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get root_path
    assert_select "title", "Class Master"
    get help_path
    assert_select "title", full_title("Help")
    get about_path
    assert_select "title", full_title("About")
    get login_path
    assert_select "title", full_title("Log in")
  end

  test "layout links with login" do
    log_in_as(@club)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", club_path(@club)
    assert_select "a[href=?]", edit_club_path(@club)
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get root_path
    assert_select "title", "Class Master"
    get help_path
    assert_select "title", full_title("Help")
    get about_path
    assert_select "title", full_title("About")
  end

  test "layout links with admin login" do
    log_in_as(@club)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", clubs_path
    assert_select "a[href=?]", club_path(@club)
    assert_select "a[href=?]", edit_club_path(@club)
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get root_path
    assert_select "title", "Class Master"
    get help_path
    assert_select "title", full_title("Help")
    get about_path
    assert_select "title", full_title("About")
  end

end