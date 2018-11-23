class User < ApplicationRecord
  has_many :applications
  has_many :missions, through: :applications
  # mount_uploader :picture, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
