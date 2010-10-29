maintainer       "Wix.com"
maintainer_email "gregory@wix.com"
license          "Apache 2.0"
description      "Installs/Configures simple_application"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.3"

%w{ ruby_enterprise passenger_enterprise apache2 rails_enterprise database capistrano git}.each do |cb|
  depends cb
end
