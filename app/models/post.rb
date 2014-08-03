class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  scope :newest_first, -> { order('created_at DESC') }

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, uniqueness: true, allow_blank: true
  validates :categories, presence: true
  validates :creator, presence: true
end