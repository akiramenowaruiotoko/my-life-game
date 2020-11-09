class Target < ApplicationRecord
  validates :content, presence: true
  validates :target_date, presence: true

  belongs_to :user
  has_one :achieve
  has_many :fights
end
