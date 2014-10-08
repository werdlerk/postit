module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def votes_total
    @votes_total ||= votes_up - votes_down
  end

  def votes_up
    votes.where(vote: true).size
  end

  def votes_down
    votes.where(vote: false).size
  end

  def has_voted_up?(user)
    votes.where(vote: true, creator: user).exists?
  end

  def has_voted_down?(user)
    votes.where(vote: false, creator: user).exists?
  end
end



# Using normal ruby metaprogramming
=begin

module Voteable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      setup
    end
  end

  module InstanceMethods
    def votes_total
      @votes_total ||= votes_up - votes_down
    end

    def votes_up
      votes.where(vote: true).size
    end

    def votes_down
      votes.where(vote: false).size
    end

    def has_voted_up?(user)
      votes.where(vote: true, creator: user).exists?
    end

    def has_voted_down?(user)
      votes.where(vote: false, creator: user).exists?
    end
  end

  module ClassMethods
    def setup
      has_many :votes, as: :voteable
    end
  end

end
=end