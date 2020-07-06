if Rails.env.production?
  Subscription.create!(name: "Free",
                       cost: 0,
                       student_limit: 20,
                       stripe_id: "",
                       description: "Whether you're just starting out, or you run a smaller club by choice, this plan will accomodate 20 students. And it's free, forever!"
                       )

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
               subscription_id: 1,
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
               subscription_id: 1,
               activated_at: Time.zone.now)
else
  article = '<div>Have you ever written a comprehensive business or marketing plan for your martial arts club, poured in your time, enthusiasm and energy, only to find six months later that you’ve referred to it a grand total of four times? That’s because traditional business metrics totally fail to capture the key factors that drive growth in a martial arts businesses, and traditional business plans are of very little value to us.<br><br>This article is the first in a series taking a comprehensive and detailed look at the key metrics needed to understand and optimise a martial arts business.<br><br>Martial arts businesses are subscription based businesses. The subscription based business model is a business model that charges customers a recurring fee — typically weekly, monthly or yearly — to access a service; in our case, valuable martial arts lessons. This series is aimed at helping martial arts instructors understand which variables matter, and how to measure them and act on the results.<br><br>By the end we will have answered the following questions:</div><ol><li>&nbsp;Will my martial arts club be a success?</li><li>&nbsp;What works well, what needs improvement?</li><li>&nbsp;Where should I focus to grow my membership base?</li><li>&nbsp;When should I hit the accelerator and when should I hit the brakes?</li></ol><h1>How are martial arts businesses different?</h1><div>We’re all familiar with traditional businesses. I go to the bakery to buy myself a vanilla slice. The cost to me is $5. The cost to them is $2 (ingredients and labour). They pocket $3 profit, and I pocket a tasty treat. Rinse and repeat on as many customers as possible, as many times as possible.<br><br></div><div>Subscription based martial arts businesses are different because the revenue for classes comes over an extended period of time (the membership lifetime). If a member is happy with classes, they will&nbsp; stick around for a very long time (we have some of the highest retention rates across sports), and the profit made from that member will increase considerably. On the other hand if a member is unhappy, they will churn quickly (churn = quit), and we will likely lose money on the investment that we made to acquire them.<br><br>Think of your club as a big bucket, and your members as water. The more water in your bucket, the more successful your club is. Imagine a stream of water filling your bucket - these are new students streaming into your club. What are your student acquisition methods? The success or failure of these methods determines the strength of that stream. Now pierce a hole somewhere in your bucket. The water will start to leak out. This represents churned students. No matter what you do, you will <em>always</em> have this leak in your bucket. Students churn from even the best classes. They get different jobs, they move away, they have children… There’s practically an infinite list of reasons why students may un-enrol from a martial arts club that they truly love being a member of. So we cannot control whether the leak exists, but we can control the size of it. Do you predict and prevent students churning? Clubs that can accurately predict students at risk of churning can take measures and rectify issues, which subsequently decreases the size of the leak.<br><br>Now think of the relationship between the stream and the leak, and how full your bucket can get. Is the leak the same size as the stream? You’ll stay where you are forever. Is the leak larger than the stream? You’re destined to fail. But when the stream is larger than the leak, that’s where your club will grow to its potential and beyond.<br><br>This is why the martial arts are fundamentally different to traditional businesses: we have two sales we need to accomplish:</div><ol><li>&nbsp;Acquiring the member (increasing the stream)</li><li>&nbsp;Retaining the member (decreasing the leak)</li></ol><div>Because of the importance of customer retention, we will see a lot of focus on metrics that help us understand retention and churn. First though, let’s take a look at metrics that will help you know if your martial arts club will be financially viable.<br><br></div><h1>The new club cash trough</h1><div>Full time martial arts businesses often take losses at some stage during their first year of operation. This is because they have to invest upfront to acquire the member, but recover the profits of that member over a long period of time. The faster you decide to grow your club, the deeper the losses become. Many club owners have a problem understanding this, and want to pull the brakes at the exact moment they should hit the accelerator.<br><br>To illustrate, here’s a graph that shows the cost and returns of acquiring <em>one</em> new member for $300, who’s charged a membership rate of $80 per month. That $300 is made up of advertising costs, deals, uniforms; whatever you spend money on <em>specifically</em> to get new students through the door. This is known as the <strong>Customer Acquisition Cost</strong> (CAC).<br><figure class="attachment attachment-preview" data-trix-attachment="{&quot;contentType&quot;:&quot;image&quot;,&quot;height&quot;:572,&quot;url&quot;:&quot;https://classmaster1.s3.amazonaws.com/uploads/blog_image/image_data/1/single_member_cash_flow.png&quot;,&quot;width&quot;:1058}" data-trix-content-type="image"><img src="https://classmaster1.s3.amazonaws.com/uploads/blog_image/image_data/1/single_member_cash_flow.png" width="1058" height="572"><figcaption class="caption"></figcaption></figure><br><br>That’s almost 4 months of running at a loss until your club sees any financial return from that member. <br><em><br>Side note: your CAC will probably be much lower than this, and your loss less, but for the sake of simple examples let\'s use large numbers.<br><br></em>The next graph shows that once that 4 month hurdle is passed, the member will continue to add more and more value to your club over time. Far more than what was initially invested to acquire them.<br><br>&nbsp;<img src="https://classmaster1.s3.amazonaws.com/uploads/blog_image/image_data/2/single_member_cumulative_cashflow.png" width="525" height="301"><figcaption class="caption"></figcaption><br><br>If we experience a temporary negative cash flow for one member, then what will happen if our student acquisition methods do really well and we start to acquire many members at the same time? This graph shows that the cash flow trough gets deeper, yet the eventual return grows exponentially higher. Continue to assume each member costs $300 to acquire and pays $20 per week, and we’re enrolling a very modest 2 per month.<br><br><figure class="attachment attachment-preview" data-trix-attachment="{&quot;contentType&quot;:&quot;image&quot;,&quot;height&quot;:431,&quot;url&quot;:&quot;https://classmaster1.s3.amazonaws.com/uploads/blog_image/image_data/3/cash_trough_single.png&quot;,&quot;width&quot;:569}" data-trix-content-type="image"><img src="https://classmaster1.s3.amazonaws.com/uploads/blog_image/image_data/3/cash_trough_single.png" width="569" height="431"><figcaption class="caption"></figcaption></figure>&nbsp;<br><br>So I started with 0 members. By the third month I’ve enrolled 6, they’re all paying membership fees, and yet we can see that I have less cash than ever! In fact at this point I’m $840 worse off than I was when I started. Let’s continue to look forward; at a point in month six I’m up to 13 members and my cash reserve is back to where it started. Now there are enough membership fees coming in from enrolled members that they cover the investment needed for new members. Carry on to month 12 and it’s obvious that our losses from the start of the year are far outweighed by the profits we’re making now.&nbsp;<br><br></div><h1>download your own spreadsheet here</h1><div>All the graphs I’m showing are available for you to <a href="https://docs.google.com/spreadsheets/d/1hr9BgsmLkhNtm7rUZJGZBy05oNAIiI132gJKpCz9DFM/edit?usp=sharing">download here</a>, so you can input your own numbers and get an idea of where you’re going. Scroll all the way to month 36 if you’d like a pleasant indication of the heights you’ll take your club to.<br><br>Let’s do some more now. We’ll increase our spending to $1,200 and $1,800 per month, so that we’re enrolling 4 and 6 new members respectfully.<br><br><figure class="attachment attachment-preview" data-trix-attachment="{&quot;contentType&quot;:&quot;image&quot;,&quot;height&quot;:426,&quot;url&quot;:&quot;https://classmaster1.s3.amazonaws.com/uploads/blog_image/image_data/4/cash_trough_multiple.png&quot;,&quot;width&quot;:578}" data-trix-content-type="image"><img src="https://classmaster1.s3.amazonaws.com/uploads/blog_image/image_data/4/cash_trough_multiple.png" width="578" height="426"><figcaption class="caption"></figcaption></figure><br><br>The trough is still deepest at month three, and the out of pocket expense is more, but the return is far higher.<br><br>At the moment our CAC is quite high. $300 spent to to enrol one student? I think we can be more efficient than that. If you’re following along on the spreadsheet at home, change the CAC to $150 and then look at the graphs change. You’ll see that our breakeven point now occurs <em>far</em> earlier than month six. Make the CAC higher than $300 and now you’ll see our breakeven occur later.<br><br>So how do we put this into action? Well, obviously there are more costs to running a club than advertising for new members. We pay for rent, insurance, electricity, <a href="https://www.attendrr.com/subscriptions">very reasonably priced student attendance software</a>, etc… Add these all up and calculate your monthly operating costs. Then use the spreadsheet to calculate your trough. I’ll use the first example where my trough was $840, and my breakeven point was month six. Now I ask myself, do I have enough money available to cover 6 months of operating costs <em>plus</em> $840 for student acquisitions? If the answer is no, I’ll need to lower my monthly spend or improve my CAC. If the answer is yes then I will consider increasing my monthly advertising to improve my rate of new enrolments, so that by month 12 that line is as high as possible.<br><br>The other advantage this metric gives us, is that we get an accurate picture of where we are. If we know with accuracy where we are, we can predict with accuracy where we’re going. Let’s imagine a scenario; your new club marketing strategy is only three months old. In those three months you’ve put your blood, sweat and tears into making it work, but no matter what you do, you seem to be making less money week after week. That would certainly dishearten some, but we know that a temporary dip in income is actually a sign that our marketing plan is working. We have been tracking our enrolments and know that we are operating at an acceptable CAC. We also know that we’re just about at the point where that line will start trending upwards, and our efforts are about to begin paying off exponentially. Where others may throw in the towel, we know it’s wiser to press forward.<br><br></div><h1>The hidden value of upfront contracts</h1><div>At this point I feel I should touch on 12-month upfront membership contracts. We’ve all seen businesses and services that offer significant discounts if you pay a full year’s fees in advance. Why is this such a common practise? Haven’t they just thrown future revenue out the window for the sake of lesser, short term gain? Well actually, no.&nbsp;<br><br>There are two good reasons for 12-month contracts:</div><ol><li>&nbsp;It has a positive effect on student retention - this is because the student has made a greater commitment to your classes, and is more likely to show up.</li><li>&nbsp;<strong>It provides the cash required to get through that initial trough we explored earlier.</strong> Paying 12 months in advance can scare some potential members away, but if you’re tactful and sensitive in your advertising and offers, offering a significant discount in exchange for a year’s fees upfront can be a very sensible move for your club’s future.</li></ol><div>Because of the losses in the early days, it can be hard for club owners to figure out whether a martial arts club will be financially viable. Even though this article is all about finances, I have to acknowledge that for many in the martial arts industry, profit comes second. Many of us run clubs because we’re passionate about our art, because we love seeing the way martial arts transforms lives, because we strive to be the best version of ourselves, because we provide a valuable service to our communities, which is awesome. This article may have you feeling like you’re looking at each new member as nothing but a dollar sign.<br><br></div><h1>All club owners are business owners</h1><div>I’ve met many club owners who wear their lack of business knowledge as a badge of honour: “I’m a martial artist, not a businessman” as if implying one can’t be both. I’m sure you’ve encountered them too. Please don’t be one. If you’d like a badge of honour, try one of these: world-class facilities for members, a team of full-time, professional instructors, free memberships for disadvantaged kids, or driving a fast car and living in a beautiful home. You decide. The secret is to do what you love and to add value to as many lives as possible. Love it or hate it, in order for your club to be healthy, it needs to be profitable.<br><br>In part two of this series we’re are going to answer the following simple question:<br><br><strong>How can I make more profit from my members than it costs me to acquire them?<br><br></strong>To do this, we\'re going to take a closer look at two metrics:<br>CAC- Customer Acquisition Cost - the monetary cost to acquire a typical member<br>LTV - Lifetime Value - I will show you some true metric magic; how to accurately predict how long people will stay members of your club, and how much they will pay you over the lifetime of their membership<br><br>Martial arts businesses are remarkably influenced by a small number of significant metrics. Making small improvements to those metrics can dramatically assist you in reaching your full potential. Although this series is long and occasionally complex, I hope it helps to provide you with an understanding of what numbers are key and how they can help you take your club to its full potential.</div>'
  lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque blandit non nulla molestie consectetur. Maecenas nisl neque, sodales ut urna sed, accumsan ultricies augue. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce in pharetra augue, vel commodo erat. Curabitur elementum lacus vel fringilla congue. Nunc vitae elit ut dolor hendrerit venenatis sed ac dolor. Cras et viverra quam. Vestibulum luctus eget dolor sit amet imperdiet. Proin eget malesuada risus, eu porttitor ex. Duis commodo viverra pharetra. Donec varius pharetra mauris a pretium. Nullam volutpat eget felis vitae commodo. Praesent vulputate a nibh non dignissim. Curabitur interdum mauris eget laoreet tincidunt.<br>In hac habitasse platea dictumst. Pellentesque quis egestas velit, vitae molestie lorem. Suspendisse ut facilisis diam. Aliquam at mi enim. Suspendisse potenti. Fusce efficitur blandit lectus a condimentum. Proin commodo elit sed viverra sodales.<br>Aliquam sed purus ullamcorper elit tincidunt vehicula quis ut quam. Phasellus eu felis quis justo ullamcorper vestibulum vel ac enim. Aliquam erat volutpat. Pellentesque dictum viverra ante, vitae tincidunt enim dictum at. Integer rutrum posuere ex, maximus fringilla massa accumsan id. Integer non nisl ut risus laoreet auctor. Quisque eu gravida justo, sed dapibus sapien. Mauris bibendum sem lectus, sollicitudin dictum ex lobortis ac. Nullam rutrum nisl elit, sed efficitur nisl gravida ac. Donec sed velit est. Donec eu lorem eget justo dignissim euismod eu at felis. Mauris sit amet elementum tellus. Nullam eget placerat diam. Nullam eget nisi tempor, blandit augue ac, iaculis urna. Vestibulum pellentesque volutpat mollis. Quisque mollis placerat nisi ut imperdiet.<br>Aenean bibendum scelerisque tincidunt. Nunc eleifend augue odio, vulputate accumsan est vestibulum in. Morbi rhoncus libero eget lectus dignissim malesuada. Vestibulum eget ipsum eu massa sollicitudin efficitur. Pellentesque a tincidunt tellus, sit amet congue ligula. Nunc dignissim tempus venenatis. Phasellus vestibulum dui pharetra augue accumsan, a efficitur sem ultricies. Aenean ac massa aliquam est tristique semper. Sed diam magna, dictum sed enim vitae, convallis dapibus sapien.<br>Donec molestie, risus ut semper porta, arcu sem mollis erat, eu ultricies massa odio ut dui. Nullam tincidunt volutpat porttitor. Nullam nibh sem, imperdiet in felis id, luctus efficitur quam. Vivamus vitae ullamcorper mi. Vestibulum nec erat nec elit rhoncus ultrices. Vivamus fringilla eget orci a imperdiet. Duis euismod eget nibh ac venenatis. Mauris commodo eros vel purus iaculis, eget scelerisque nunc elementum. Etiam fermentum dapibus tellus et auctor. Aliquam mollis tellus ac lacus aliquam dictum. Sed id bibendum urna, at maximus eros."
  9.times { |i|
  BlogPost.create!(title: "Lorem Ipsum #{i}",
                   subtitle: "Dolor sit amet",
                   picture: open('app/assets/images/attendrr_master_black_background.png'),
                   content: article)
  }
  Subscription.create!(name: "Free Forever",
                       cost: 0,
                       stripe_id: "",
                       student_limit: 200,
                       description: "Whether you're just starting out, or you run a smaller club by choice, this plan will accomodate 20 students. And it's free, forever!")
  Subscription.create!(name: "Silver",
                       cost: 3000,
                       stripe_id: "plan_H8vl5wUWxyUubB",
                       student_limit: 300,
                       description: "You're onto something here. For medium-sized clubs of up to 30 students")
  Subscription.create!(name: "Gold",
                       cost: 5000,
                       stripe_id: "plan_H8vm73Ow5Aff22",
                       student_limit: 500,
                       description: "Now you're formidable! For clubs of up to 50 students")
  Subscription.create!(name: "Platinum",
                       cost: 10000,
                       stripe_id: "plan_H8vmNO1zUmFL3U",
                       student_limit: 999,
                       description: "Woah! It's huge! Have unlimited students on the Platinum plan!")

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
               subscription_id: 4,
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
    first_random = rand(1..3)
    second_random = rand(1..3)
    third_random = rand(4..6)
    StudentRank.create!(student_id: n+1,
                        rank_id: first_random,
                        active: true)
    if first_random != second_random
      StudentRank.create!(student_id: n+1,
                          rank_id: third_random,
                          active: true)
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