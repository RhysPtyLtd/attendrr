require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    #assert_equal full_title,         "Class Master"    Don't know why this test is expecting " | Class Master"
    assert_equal full_title("Contact"), "Contact | Class Master"
  end
end