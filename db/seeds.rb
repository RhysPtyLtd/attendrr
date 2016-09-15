if Rails.env.production?
  Club.create!(name: "ADMIN",
               email: "rphillips1@live.com.au",
               password: "password",
               password_confirmation: "password",
               address_line_1: "30 Sportsman Ave.", 
               address_line_2: "Unit 67"
               city: "Mermaid Beach",
               state: "QLD", 
               postcode: 4218, 
               country: "Australia", 
               phone1: "0421793832",
               owner_first_name: "Rhys", 
               owner_last_name: "Phillips",
               admin: true)

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
               owner_last_name: "Lin"
               )
else
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
               admin: true)

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
               owner_last_name: "Lin"
               )

  99.times do |n|
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
                 owner_last_name: owner_last_name)
  end
end