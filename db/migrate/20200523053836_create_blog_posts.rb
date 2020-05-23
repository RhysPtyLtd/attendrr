class CreateBlogPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_posts do |t|
      t.string :title, presence: true
      t.string :subtitle
      t.text :content, presence: true

      t.timestamps
    end
  end
end
