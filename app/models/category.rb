class Category < ActiveRecord::Base
  include Slug

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true
end