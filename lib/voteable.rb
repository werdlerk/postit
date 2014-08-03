module Voteable
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