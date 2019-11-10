desc "Test of rake tasks"
task :generate_daily_financial_report => :environment do
	clubs = Club.all
	clubs.each do |c|
		c.students.each do |s|
  			if s.payment_plan.frequency.present?
  				DailyFinancialReport.create(
  					club_id: s.club.id,
  					student_id: s.id,
  					payment_plan_id: s.payment_plan.id,
  					price: s.payment_plan.price,
  					regularity: s.payment_plan.frequency,
  					daily_value: s.payment_plan.daily_value,
  					reccuring: true
  				)
  			end
  		end
  	end
end