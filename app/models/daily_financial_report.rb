class DailyFinancialReport < ApplicationRecord
  belongs_to :club
  belongs_to :student
  belongs_to :payment_plan
end
