class Target < ApplicationRecord
  validates :content, presence: true
  validates :target_date, presence: true
  validates :achieve, inclusion: { in: [true, false]}

  belongs_to :user
  has_many :fights
end
