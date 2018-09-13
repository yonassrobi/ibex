#
# Cookbook:: data
# Recipe:: default

# MySQL setup ---------------------------------------------
execute "mysql server rpm" do
  command "wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm"
end

execute "mysql server rpm" do
  command "rpm -ivh mysql-community-release-el7-5.noarch.rpm"
  ignore_failure true
end

package "mysql-server"

service "mysql" do
  action [:enable, :start]
end

execute "mysql set root password" do
  command "mysqladmin -u root password root"
  ignore_failure true
end

execute "create test db" do
  command 'mysqladmin -uroot -proot create testdb';
  ignore_failure true
end
