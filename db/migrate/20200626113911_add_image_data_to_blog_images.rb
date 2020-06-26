class AddImageDataToBlogImages < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_images, :image_data, :text
  end
end
