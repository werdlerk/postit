module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
  end

  def to_param
    self.slug
  end

  def generate_slug!
    if self.respond_to? :title
      slug = to_slug(self.title)
    elsif self.respond_to? :name
      slug = to_slug(self.name)
    elsif self.respond_to? :username
      slug = to_slug(self.username)
    end

    count = 2
    post = self.class.find_by_slug(slug)

    while (post && post != self)
      slug = to_slug(self.title) + "-" + count.to_s
      post = self.class.find_by_slug(slug)
      count += 1
    end

    self.slug = slug
  end

  def to_slug(str)
    str.strip.downcase
      .gsub(/(&|&amp;)/, ' and ')
      .gsub(/[\s\.\/\\]/, '-')
      .gsub(/[^\w-]/, '')
      .gsub(/[-_]{2,}/, '-')
      .gsub(/^[-_]/, '')
      .gsub(/[-_]$/, '')
  end

end