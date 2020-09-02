desc "Creates daily financial records in the database for each club. Called by the Heroku scheduler add-on"
task :generate_daily_metrics => :environment do
  records = Club.includes(:students)
  records.each do |record|
    puts "Generating report for " + record.name
    total_active_students = 0
    lost_students = 0
    new_students = 0
    churn = 0
    revenue = 0
    record.students.each do |stu|
      total_active_students += 1 if stu.active?
      lost_students += 1 if (stu.active == false && stu.updated_at.to_date == Date.today)
      new_students += 1 if stu.created_at.to_date == Date.today
      revenue += stu.payment_plan.daily_value
    end
    churn = total_active_students - new_students if lost_students != 0
    DailyMetric.create(
      club_id: record.id,
      total_active_students: total_active_students,
      lost_students: lost_students,
      new_students: new_students,
      revenue: revenue
    )
  end
  puts "Reporting completed at " + Time.now.to_s
end