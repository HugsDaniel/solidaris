class User < ApplicationRecord
  has_many :applications
  has_many :missions, through: :applications
  has_many :organizations, foreign_key: :manager_id

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  # mount_uploader :picture, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.policy_class
    Account::ProfilePolicy
  end
end
