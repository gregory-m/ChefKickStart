name "5_minutes_blog"
description "My blog in 5 minutes on Rails + ree + passanger + apache + mysq"
run_list("recipe[users::sysadmins]", "recipe[ruby_enterprise::default]", "recipe[passenger_enterprise::apache2]",
          "recipe[rails_enterprise::default]", "recipe[mysql::server]")
          