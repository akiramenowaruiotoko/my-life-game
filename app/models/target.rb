class Target < ApplicationRecord
  belongs_to :user
  has_many :fights, dependent: :destroy

  with_options presence: true do
    validates :content
    validates :target_date
  end
  validates :achieve, inclusion: { in: [true, false]}
end
