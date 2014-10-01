class AddSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string, before: :created_at
  end
end
