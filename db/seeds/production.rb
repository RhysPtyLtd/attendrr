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
          owner_last_name: "Lin")