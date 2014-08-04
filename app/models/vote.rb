class Vote < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :voteable, polymorphic: true

  validates :creator, uniqueness: { scope: [:vote, :voteable], message: "You can only vote once" }
  # validates_uniqueness_of :creator, scope: [:vote, :voteable], message: "You can only vote once"
end