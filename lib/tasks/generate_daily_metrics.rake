desc "Creates daily financial records in the database for each club. Called by the Heroku scheduler add-on"
task :generate_daily_metrics => :environment do
  Club.all.each do |c|
    puts "Generating report for " + c.name
    total_active_students = 0
    lost_students = 0
    new_students = 0
    churn = 0
    c.students.each do |s|
      total_active_students += 1 if s.active?
      lost_students += 1 if (s.active == false && s.updated_at.to_date == Date.today)
      new_students += 1 if s.created_at.to_date == Date.today
    end
    churn = total_active_students - new_students if lost_students != 0
    DailyMetric.create(
      club_id: c.id,
      total_active_students: total_active_students,
      lost_students: lost_students,
      new_students: new_students
    )
  end
  puts "Reporting completed at " + Time.now.to_s
end