require 'test_helper'

class ClubsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = clubs(:michael)
    @non_admin = clubs(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'div.pagination'
    first_page_of_clubs = Club.paginate(page: 1)
    first_page_of_clubs.each do |club|
      assert_select 'a[href=?]', club_path(club), text: club.name
      unless club == @admin
        assert_select 'a[href=?]', club_path(club), text: 'delete'
      end
    end
    assert_difference 'Club.count', -1 do
      delete club_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get clubs_path
    assert_select 'a', text: 'delete', count: 0
  end
end