module StudentLimit

	def self.over?(club)
		active_student_count = club.students.includes(:payment_plan).where.not(payment_plans: {name: 'Prospect'}).where(active: true).count
		student_limit = club.subscription.student_limit
		active_student_count > student_limit
	end

end