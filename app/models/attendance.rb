class Attendance < ApplicationRecord
  belongs_to :student, touch: true
  belongs_to :activity
  belongs_to :timeslot
  belongs_to :rank

  def find_rank
  	rank_id = self.student.ranks.where(activity_id: self.activity.id).first.id
  	self.student.ranks.where(activity_id: self.activity.id).order("created_at desc").each do |rank|
  		if rank.created_at > self.attended_on
  			rank_id = rank.id
  		end
  	end
  	rank_id
  end
end
