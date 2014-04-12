class AddUserRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :user, index: true, after: :description
  end
end
