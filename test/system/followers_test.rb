require "application_system_test_case"

class FollowersTest < ApplicationSystemTestCase
  setup do
    @follower = followers(:one)
  end

  test "visiting the index" do
    visit followers_url
    assert_selector "h1", text: "Followers"
  end

  test "creating a Follower" do
    visit followers_url
    click_on "New Follower"

    check "Active" if @follower.active
    fill_in "Email", with: @follower.email
    fill_in "Name", with: @follower.name
    click_on "Create Follower"

    assert_text "Follower was successfully created"
    click_on "Back"
  end

  test "updating a Follower" do
    visit followers_url
    click_on "Edit", match: :first

    check "Active" if @follower.active
    fill_in "Email", with: @follower.email
    fill_in "Name", with: @follower.name
    click_on "Update Follower"

    assert_text "Follower was successfully updated"
    click_on "Back"
  end

  test "destroying a Follower" do
    visit followers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Follower was successfully destroyed"
  end
end
