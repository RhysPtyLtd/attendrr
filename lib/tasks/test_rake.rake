desc "Test of rake tasks"
task :rake_tester => :environment do
  henrys = Club.find_by(name: "Rhys Karate!")
  	henrys.students.each do |s|
  		if s.payment_plan.frequency.present?
  			puts s.first_name.upcase + " " + s.last_name.upcase
  			puts "1. " + s.payment_plan.name
  			puts "2. " + s.payment_plan.price.to_s
  			puts "3. " + s.payment_plan.frequency
  			puts "4. " + s.payment_plan.daily_value.to_s
  		end
  	end
  
end