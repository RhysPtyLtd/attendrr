class AddPictureToBlogPost < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_posts, :picture, :string
  end
end
