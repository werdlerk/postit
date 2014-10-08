module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug!
    slug = to_slug(self.send(self.class.slug_column.to_sym))
    count = 2
    obj = self.class.find_by_slug(slug)

    while (obj && obj != self)
      slug = to_slug(self.title) + "-" + count.to_s
      obj = self.class.find_by_slug(slug)
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

  module ClassMethods
    def sluggable_column(column_name)
      self.slug_column = column_name
    end
  end

end