class PaymentPlan < ApplicationRecord
  belongs_to :club
  has_many :students
end
