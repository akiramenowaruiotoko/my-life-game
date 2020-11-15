class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :free_time, presence: true
  validates :private_mode, inclusion: { in: [true, false]}

  has_many :targets
  has_many :fights
end
