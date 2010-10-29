#
# Cookbook Name:: simple_application
# Recipe:: default
#
# Copyright 2010, Wix.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "ruby_enterprise::default"
include_recipe "passenger_enterprise::apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "rails_enterprise::default"
include_recipe "database::simple"
include_recipe "capistrano::default"


node[:apps].each do |app|
  server_aliases = [ "#{app['id']}.#{node[:domain]}", node.fqdn ]
  
  
  web_app app['id'] do
    #cookbook "apache2"
    docroot "/var/www/#{app['id']}/current/public"
    server_name "#{app['id']}.#{node[:domain]}"
    server_aliases server_aliases
    log_dir node[:apache][:log_dir]
    rails_env "production"
  end
  
  cap_setup  app['id'] do
    path "/var/www/#{app['id']}"
    owner "nobody"
    group "nogroup"
    appowner "nobody"
  end
end

apache_site "000-default" do
  enable false
end