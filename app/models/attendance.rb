class Attendance < ApplicationRecord
  belongs_to :student, touch: true
  belongs_to :activity
  belongs_to :timeslot
  belongs_to :rank
  before_save :check_duplicate_records

  def find_rank
    rank_id = self.student.ranks.where(activity_id: self.activity.id).first.id
    self.student.ranks.where(activity_id: self.activity.id).order("created_at desc").each do |rank|
      if rank.created_at > self.attended_on
        rank_id = rank.id
      end
    end
    rank_id
  end

  def check_duplicate_records
    if Attendance.where("timeslot_id =? AND Date(created_at) = DATE(?) AND student_id =? AND Date(attended_on) = DATE(?)", self.timeslot_id, Date.today, self.student_id, self.attended_on).count > 0
      raise ActiveRecord::Rollback
    end
  end

end