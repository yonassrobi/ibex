#
# Cookbook:: api
# Recipe:: default

package "java"
package "maven"
package "git"

execute "Update nss curl libcurl" do
  command "yum update -y nss curl libcurl"
end

# Firewall  ---------------------------------------------
execute "httpd_firewall" do
  command "/usr/bin/firewall-cmd  --permanent --zone public --add-service http"
  ignore_failure true
end

execute "reload_firewall" do
  command "/usr/bin/firewall-cmd --reload"
  ignore_failure true
end

# Create apps folder
%w(apps).each do |dir|
  directory "#{node['app']['dir']}/#{dir}" do
    owner node['user']['name']
    group node['user']['name']
    mode "0755"
    recursive true
  end
end

# Spring-boot App  ---------------------------------------------
git "#{node['app']['dir']}/apps" do
  destination "#{node['app']['dir']}/apps"
  repository "https://github.com/only2dhir/spring-boot-angular5.git"
  user node['user']['name']
  reference "master"
  action :sync
end

file "#{node['app']['dir']}/apps/user-portal/mvnw" do
  mode "0755"
end

execute "maven build" do
  cwd "#{node['app']['dir']}/apps/user-portal/"
  command "mvn clean install -Dmaven.test.failure.ignore=true"
end

execute "api in the background" do
  cwd "#{node['app']['dir']}/apps/user-portal/target/"
  command "nohup java -jar user-portal-*.jar &"
end
