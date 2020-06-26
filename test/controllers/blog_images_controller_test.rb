require 'test_helper'

class BlogImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog_image = blog_images(:one)
  end

  test "should get index" do
    get blog_images_url
    assert_response :success
  end

  test "should get new" do
    get new_blog_image_url
    assert_response :success
  end

  test "should create blog_image" do
    assert_difference('BlogImage.count') do
      post blog_images_url, params: { blog_image: {  } }
    end

    assert_redirected_to blog_image_url(BlogImage.last)
  end

  test "should show blog_image" do
    get blog_image_url(@blog_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_blog_image_url(@blog_image)
    assert_response :success
  end

  test "should update blog_image" do
    patch blog_image_url(@blog_image), params: { blog_image: {  } }
    assert_redirected_to blog_image_url(@blog_image)
  end

  test "should destroy blog_image" do
    assert_difference('BlogImage.count', -1) do
      delete blog_image_url(@blog_image)
    end

    assert_redirected_to blog_images_url
  end
end
