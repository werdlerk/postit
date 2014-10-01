class AddSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string, before: :created_at
    add_index :posts, :slug, unique: true

    Post.find_each(&:save)
  end
end
