class Vote < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :voteable, polymorphic: true

  # validates :voteable, uniqueness: { scope: [:vote, :creator], message: "You can only vote once" }
end