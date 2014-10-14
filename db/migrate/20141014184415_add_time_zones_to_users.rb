class AddTimeZonesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string, before: :created_at
  end
end
