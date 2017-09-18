class PaymentPlan < ApplicationRecord
  belongs_to :club
  has_many :students
  validates :price, presence: true
  validates :name, presence: true
  validates :frequency, presence: true
end
