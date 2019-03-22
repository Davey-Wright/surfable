class User < ApplicationRecord
  has_many :spots, dependent: :delete_all

  validates :first_name, presence: true
  validates :last_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def remember_me
    true
  end
end
