require "application_system_test_case"

class BlogImagesTest < ApplicationSystemTestCase
  setup do
    @blog_image = blog_images(:one)
  end

  test "visiting the index" do
    visit blog_images_url
    assert_selector "h1", text: "Blog Images"
  end

  test "creating a Blog image" do
    visit blog_images_url
    click_on "New Blog Image"

    click_on "Create Blog image"

    assert_text "Blog image was successfully created"
    click_on "Back"
  end

  test "updating a Blog image" do
    visit blog_images_url
    click_on "Edit", match: :first

    click_on "Update Blog image"

    assert_text "Blog image was successfully updated"
    click_on "Back"
  end

  test "destroying a Blog image" do
    visit blog_images_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blog image was successfully destroyed"
  end
end
