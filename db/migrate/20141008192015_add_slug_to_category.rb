class AddSlugToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string, before: :created_at
    add_index :categories, :slug, unique: true

    Category.find_each(&:save)
  end
end
