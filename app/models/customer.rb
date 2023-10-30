class Customer < ApplicationRecord
  validates :first_name, presence: true 
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true 
  validates :address, presence: true

  has_many :subscriptions
end