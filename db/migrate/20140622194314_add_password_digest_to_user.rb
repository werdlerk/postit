class AddPasswordDigestToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string, after: :username
  end
end
