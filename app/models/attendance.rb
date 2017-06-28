class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :activity
  belongs_to :timeslot

  def find_rank
  	ranks_student = self.student.rank.where(activity_id: student.activity.id)
  end
end
