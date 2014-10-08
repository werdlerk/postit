class AddSlugToUser < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string, before: :created_at
    add_index :users, :slug, unique: true

    User.find_each(&:save)
  end
end
