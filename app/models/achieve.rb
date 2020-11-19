class Achieve < ApplicationRecord
  belongs_to :target

  validates :target_id, uniqueness: true
end
