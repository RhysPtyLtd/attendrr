class CreateBlogImages < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_images do |t|

      t.timestamps
    end
  end
end
