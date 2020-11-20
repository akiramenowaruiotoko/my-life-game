class Target < ApplicationRecord
  belongs_to :user
  has_one    :achieve, dependent: :destroy
  has_many   :fights, dependent: :destroy

  with_options presence: true do
    validates :content
    validates :target_date
    validates :user
  end

  def already_achieved?(target)
    Achieve.exists?(target_id: target.id)
  end
end
