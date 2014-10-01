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

  before_save :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    slug = to_slug(self.title)
    count = 2
    post = Post.find_by_slug(slug)

    while (post && post != self)
      slug = to_slug(self.title) + "-" + count.to_s
      post = Post.find_by_slug(slug)
      count += 1
    end

    self.slug = slug
  end

  def to_slug(title)
    title.strip.downcase
      .gsub(/(&|&amp;)/, ' and ')
      .gsub(/[\s\.\/\\]/, '-')
      .gsub(/[^\w-]/, '')
      .gsub(/[-_]{2,}/, '-')
      .gsub(/^[-_]/, '')
      .gsub(/[-_]$/, '')
  end


end