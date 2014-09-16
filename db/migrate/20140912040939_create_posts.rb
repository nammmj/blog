class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
