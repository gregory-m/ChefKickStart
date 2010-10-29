name "5_minutes_blog"
description "My blog in 5 minutes on Rails + ree + passanger + apache + mysql"

run_list("recipe[users::sysadmins]","recipe[sudo::default]" ,"recipe[simple_application::default]")

default_attributes("apps" => [
                             "id" => "5_minutes_blog",
                             "databases" => 
                                {"production" => {
                                  "adapter" => "mysql",
                                  "database" => "5_minutes_blog_production",
                                  "encoding" => "utf8",
                                  "password" => "awesome_password",
                                  "reconnect" => true,
                                  "username" => "5_minutes"
                                  }}
                              ],
                    "authorization" => {
                      "sudo" => {
                        "groups" => ["wheel", "sysadmin"],
                        "users" => ["gregory", "labria"]
                      }
                    })
                                                  # 
