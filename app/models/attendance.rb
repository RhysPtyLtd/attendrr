class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :activity
  belongs_to :timeslot
end
