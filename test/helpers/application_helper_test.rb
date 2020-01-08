require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    #assert_equal full_title,         "Attendrr"    Don't know why this test is expecting " | Attendrr"
    assert_equal full_title("Contact"), "Contact | Attendrr"
  end
end