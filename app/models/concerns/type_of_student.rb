module TypeOfStudent

	def self.active(club)
		club.students.where(active: true)
	end

	def self.active_enrolled(club)
		club.students.includes(:payment_plan).where.not(payment_plans: {name: 'Prospect'}).where(active: true)
	end

	def self.deactivated_enrolled(club)
		club.students.includes(:payment_plan).where.not(payment_plans: {name: 'Prospect'}).where(active: false)
	end

	def self.all_prospects(club)
		club.students.includes(:payment_plan).where(payment_plans: {name: 'Prospect'})
	end

	def self.active_prospects(club)
		club.students.includes(:payment_plan).where(payment_plans: {name: 'Prospect'}).where(active: true)
	end

	def self.deactivated_prospects(club)
		club.students.includes(:payment_plan).where(payment_plans: {name: 'Prospect'}).where(active: false)
	end

end