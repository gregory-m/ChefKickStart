#
# Author:: Gregory Man (<gregory@wix.com>)
# Cookbook Name:: database
# Recipe:: simple
#
# Copyright 2006-2010, Wix, Inc.
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

db_info = Hash.new
root_pw = String.new

node[:apps].each do |app|
  app[:databases].each do |env, db|
    db_info[env] = db
  end
end

include_recipe "mysql::server"

grants_path = value_for_platform(
  ["centos", "redhat", "suse", "fedora" ] => {
    "default" => "/etc/mysql_app_grants.sql"
  },
  "default" => "/etc/mysql/app_grants.sql"
)

template "/etc/mysql/app_grants.sql" do
  path grants_path
  source "app_grants.sql.erb"
  cookbook "database"
  owner "root"
  group "root"
  mode "0600"
  action :create
  variables :db_info => db_info
end

execute "mysql-install-application-privileges" do
  command "/usr/bin/mysql -u root #{node[:mysql][:server_root_password].empty? ? '' : '-p' }#{node[:mysql][:server_root_password]} < #{grants_path}"
  action :nothing
  subscribes :run, resources(:template => "/etc/mysql/app_grants.sql"), :immediately
end

Gem.clear_paths
require 'mysql'

node[:apps].each do |app|
  app[:databases].each do |env, db|
    root_pw = node["mysql"]["server_root_password"]
    mysql_database "create #{db['database']}" do
      host "localhost"
      username "root"
      password root_pw
      database db['database']
      action [:create_db]
    end
  end
end
