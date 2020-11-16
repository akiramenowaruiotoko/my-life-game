class Fight < ApplicationRecord
  belongs_to :user
  belongs_to :target

  validates_uniqueness_of :target_id, scope: :user_id
end
