class Organization < ApplicationRecord
  validates :name, :description,
            :kind, :category, :email, :phone_number,
            presence: true

  validates :name, uniqueness: true

  belongs_to :manager, class_name: 'User', foreign_key: :manager_id
  has_many :missions
end
