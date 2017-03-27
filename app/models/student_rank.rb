class StudentRank < ApplicationRecord
  belongs_to :student
  belongs_to :rank
  after_create :deactivate_lower_ranks
end

def deactivate_lower_ranks
	self.student.student_ranks.each do |sr|
		if (sr.rank.activity == self.rank.activity) && (sr.rank.position < self.rank.position)
			sr.update_attribute(:active, false)
		end
	end
end