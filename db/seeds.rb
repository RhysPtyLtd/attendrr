if Rails.env.production?
  Subscription.create!(name: "Free",
                       cost: 0)
  
  Club.create!(name: "ADMIN",
               email: "rphillips1@live.com.au",
               password: "password",
               password_confirmation: "password",
               address_line_1: "30 Sportsman Ave.", 
               address_line_2: "Unit 67",
               city: "Mermaid Beach",
               state: "QLD", 
               postcode: 4218, 
               country: "Australia", 
               phone1: "0421793832",
               owner_first_name: "Rhys", 
               owner_last_name: "Phillips",
               admin: true,
               activated: true,
               activated_at: Time.zone.now)

  Club.create!(name: "Henry's Kungfu",
               email: "henry@kungfu.com",
               password: "password",
               password_confirmation: "password",
               address_line_1: "888 Avenue Ln.", 
               city: "Townsholme",
               state: "WA", 
               postcode: 8989, 
               country: "China", 
               phone1: "0409586943",
               owner_first_name: "Henry", 
               owner_last_name: "Lin",
               activated: true,
               activated_at: Time.zone.now)
else
  Subscription.create!(name: "Free",
                       cost: 0)
  Subscription.create!(name: "Silver",
                       cost: 2990)
  Subscription.create!(name: "Gold",
                       cost: 4990)
  Subscription.create!(name: "Platinum",
                       cost: 9990)

  Club.create!(name: "Kapow Karate!",
               email: "tester@classmaster.com",
               password: "password",
               password_confirmation: "password",
               address_line_1: "123 Street St.", 
               city: "Hometown",
               state: "VIC", 
               postcode: 1234, 
               country: "Turkmenistan", 
               phone1: "985764345",
               owner_first_name: "Greg", 
               owner_last_name: "Egg",
               admin: true,
               activated: true,
               activated_at: Time.now-1.year+1.hour,
               created_at: Time.now-1.year)



  #Club.create!(name: "Henry's Kungfu",
               #email: "henry@kungfu.com",
               #password: "password",
               #password_confirmation: "password",
               #address_line_1: "888 Avenue Ln.", 
               #city: "Townsholme",
               #state: "WA", 
               #postcode: 8989, 
               #country: "China", 
               #phone1: "0409586943",
               #owner_first_name: "Henry", 
               #owner_last_name: "Lin",
               #activated: true,
               #activated_at: Time.zone.now)

  # Create students
  99.times do |n|
    club_id = 1 #Faker::Number.between(1, 2)
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    address_line_1 = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state
    postcode = Faker::Address.postcode
    phone1 = Faker::PhoneNumber.phone_number
    dob = Faker::Date.between(100.years.ago, 6.years.ago)
    email = Faker::Internet.email(first_name)
    created_at = Faker::Date.between(Time.now-1.year, Date.today)
    #payment_plan = rand(1..4)
    Student.create!(club_id: club_id,
                    first_name: first_name,
                    last_name: last_name,
                    address_line_1: address_line_1,
                    city: city,
                    state: state,
                    postcode: postcode,
                    phone1: phone1,
                    dob: dob,
                    email: email,
                    #payment_plan_id: 2,
                    created_at: created_at)
  end

  #Create activities (with ranks and timeslots)
  Activity.create!(club_id: 1,
                   name: "Karate",
                   active: true,)

    Timeslot.create!(time_start: Time.now-1.year+1.hour,
                     time_end: Time.now-1.year+3.hours,
                     day: 5,
                     activity_id: 1,
                     schedule: Time.now-1.year+1.hour,
                     active: true,
                     created_at: Time.now-1.year+1.hour)
    Timeslot.create!(time_start: Time.now-1.year+1.hour,
                     time_end: Time.now-1.year+3.hours,
                     day: 1,
                     activity_id: 1,
                     schedule: Time.now-1.year+1.hour,
                     active: true,
                     created_at: Time.now-1.year+1.hour)

    Rank.create!(name: "White belt",
                 position: 0,
                 activity_id: 1,
                 active: true)
    Rank.create!(name: "Yellow belt",
                 position: 1,
                 activity_id: 1,
                 active: true)
    Rank.create!(name: "Orange belt",
                 position: 2,
                 activity_id: 1,
                 active: true)

  Activity.create!(club_id: 1,
                   name: "Fitness Kickboxing",
                   active: true,)
    Timeslot.create!(time_start: Time.now-1.year+1.hour,
                     time_end: Time.now-1.year+3.hours,
                     day: 3,
                     activity_id: 2,
                     schedule: Time.now-1.year+1.hour,
                     active: true,
                     created_at: Time.now-1.year+1.hour)
    Timeslot.create!(time_start: Time.now-1.year+1.hour,
                     time_end: Time.now-1.year+3.hours,
                     day: 1,
                     activity_id: 2,
                     schedule: Time.now-1.year+1.hour,
                     active: true,
                     created_at: Time.now-1.year+1.hour)

    Rank.create!(name: "First",
                 position: 0,
                 activity_id: 2,
                 active: true)
    Rank.create!(name: "Second",
                 position: 1,
                 activity_id: 2,
                 active: true)
    Rank.create!(name: "Third",
                 position: 2,
                 activity_id: 2,
                 active: true)

  # Create student ranks
  99.times do |n|
    # first and second randoms ensure a student isn't given the multiple same ranks
    first_random = rand(1..6)
    second_random = rand(1..6)
    StudentRank.create!(student_id: n+1,
                        rank_id: first_random,
                        active: true)
    if first_random != second_random
      StudentRank.create!(student_id: n+1,
                          rank_id: second_random,
                          active: [true, false].sample)
    end
  end

  # Create payment plans
  PaymentPlan.create!(club_id: 1,
                      name: "Gold",
                      price: 30.00,
                      frequency: "Weekly",
                      active: true)
  PaymentPlan.create!(club_id: 1,
                      name: "Silver",
                      price: 20.00,
                      frequency: "Weekly",
                      active: true)
  PaymentPlan.create!(club_id: 1,
                      name: "10-class pass",
                      price: 100.00,
                      active: true,
                      classes_amount: 10,
                      frequency: 'Per class')

  # Assign payment plans to students
  99.times do |n|
    payment_plan = rand(1..4)
    Student.update(n+1, payment_plan_id: payment_plan)
  end

  # Deactivate random number of students
  99.times do |n|
    created_at = Student.find(n+1).created_at
    if rand(1..5) == 5
      updated_at = Faker::Date.between(created_at, Date.today)
      active_status = false
    else
      active_status = true
      updated_at = Date.today
    end
    Student.update(n+1, active: active_status)
    Student.update(n+1, updated_at: updated_at)
  end

  # Create a random club
  1.times do |n|
    name  = Faker::Company.name
    email = "example-#{n+1}@faketest.com"
    password = "password"
    address_line_1 = Faker::Address.street_address
    address_line_2 = Faker::Address.secondary_address
    city = Faker::Address.city
    state = Faker::Address.state
    postcode = Faker::Address.postcode
    country = Faker::Address.country
    phone1 = Faker::PhoneNumber.phone_number
    owner_first_name = Faker::Name.first_name
    owner_last_name = Faker::Name.last_name
    Club.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password,
                 address_line_1: address_line_1,
                 address_line_2: address_line_2,
                 city: city,
                 state: state,
                 postcode: postcode,
                 country: country,
                 phone1: phone1,
                 owner_first_name: owner_first_name,
                 owner_last_name: owner_last_name,
                 activated: true,
                 activated_at: Time.zone.now)
  end

  # Create daily metrics
  total_active_students = 0
  365.times do |n|
    iterated_date = Time.now - 1.year + n.days
    new_students = Student.where(:created_at => (iterated_date.beginning_of_day..iterated_date.end_of_day)).count
    lost_students = Student.where(:updated_at => (iterated_date.beginning_of_day..iterated_date.end_of_day)).where(active: false).count
    total_active_students += (new_students - lost_students)
    DailyMetric.create!(club_id: 1,
                        total_active_students: total_active_students,
                        lost_students: lost_students,
                        new_students: new_students,
                        revenue: total_active_students * 4,
                        created_at: iterated_date)
  end

end