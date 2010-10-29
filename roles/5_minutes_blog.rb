name "5_minutes_blog"
description "My blog in 5 minutes on Rails + ree + passanger + apache + mysq"
run_list("recipe[users::sysadmins]", "recipe[ruby_enterprise::default]", "recipe[passenger_enterprise::apache2]",
          "recipe[rails_enterprise::default]", "recipe[database::simple]")

default_attributes("apps" => ["databases" => {"test" => {"myt" => "111"}}])
 

                                                  # 
                                                  # "production" => {
                                                  #   "adapter" => "mysql",
                                                  #   "database" => "5_minutes_blog_production",
                                                  #   "encoding" => "utf8",
                                                  #   "password" => "awesome_password",
                                                  #   "reconnect" => true,
                                                  #   "username" => "5_minutes"
                                                  #   }