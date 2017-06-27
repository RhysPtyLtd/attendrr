class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :activity
  belongs_to :timeslot

  def find_rank
  	self.student.rank.where()
  end
end
