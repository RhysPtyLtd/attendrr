class PaymentPlan < ApplicationRecord
  belongs_to :club
  has_many :students
  validates :price, presence: true
  validates :name, presence: true
  before_save :calculate_daily_value
end

def calculate_daily_value
	daily_value = 0
	if self.frequency == "Weekly"
		daily_value = self.price/7
	elsif self.frequency == "2-weekly"
		daily_value = self.price/14
	elsif self.frequency == "Monthly"
		daily_value = self.price/30.4167
	elsif self.frequency == "Quarterly"
		daily_value = self.price/91.25
	elsif self.frequency == "6-monthly"
		daily_value = self.price/182.5
	elsif self.frequency == "Yearly"
		daily_value = self.price/365
	end
	self.daily_value = daily_value.round(2)
end