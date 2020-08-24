class Attendance < ApplicationRecord
  belongs_to :student, touch: true
  belongs_to :activity
  belongs_to :timeslot
  belongs_to :rank
  validate :check_records

  def find_rank
  	rank_id = self.student.ranks.where(activity_id: self.activity.id).first.id
  	self.student.ranks.where(activity_id: self.activity.id).order("created_at desc").each do |rank|
  		if rank.created_at > self.attended_on
  			rank_id = rank.id
  		end
  	end
  	rank_id
  end

  private

  def check_records
    date = ( created_at || Date.current ).to_date
    if self.class.exists? ["timeslot_id =? AND student_id = ?", timeslot_id, student_id]
      errors.add :student_id, "is not unique for #{date}"
    end
  end
end
