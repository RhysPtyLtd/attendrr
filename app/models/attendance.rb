class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :activity
  belongs_to :timeslot

  def find_rank
  	rank_name = self.student.ranks.where(activity_id: self.activity.id).first.name
  	self.student.ranks.where(activity_id: self.activity.id).order("created_at desc").each do |rank|
  		if rank.created_at > self.attended_on
  			rank_name = rank.name 
  		end
  	end
  	rank_name
  end
end
