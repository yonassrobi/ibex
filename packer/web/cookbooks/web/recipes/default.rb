#
# Cookbook:: web
# Recipe:: default

# ---------------------------------------------------------------------------------------------------------------------
# - NGINX Configuration -
# ---------------------------------------------------------------------------------------------------------------------
include_recipe 'nginx::repo'

package 'nginx' do
  action :install
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [ :enable, :start ]
end

# create sites-enabled and sites-available folders
%w(sites-enabled sites-available).each do |dir|
  directory "#{node['nginx']['dir']}/#{dir}" do
    owner node['user']['name']
    mode "0755"
    recursive true
  end
end

# replace main nginx config with template
template "#{node['nginx']['dir']}/nginx.conf" do
  source "nginx.conf.erb"
  mode "0644"
end

# copy web.conf template to sites available folder
template "#{node['nginx']['dir']}/sites-available/#{node['app']['name']}.conf" do
  source "web.conf.erb"
  mode "0644"
end

# create symlink of web.conf file from sites-available to sites-enabled folder
execute "allow selinux newtwork connect for proxy" do
  command "ln -sf #{node['nginx']['dir']}/sites-available/#{node['app']['name']}.conf #{node['nginx']['dir']}/sites-enabled/#{node['app']['name']}.conf"
  notifies :reload, "service[nginx]"
end

# enable selinux network can connect setting for reverse proxy
execute "allow selinux newtwork connect for proxy" do
  command "setsebool httpd_can_network_connect on -P"
end

# ---------------------------------------------------------------------------------------------------------------------
# - Firewall -
# ---------------------------------------------------------------------------------------------------------------------
execute "httpd_firewall" do
  command "/usr/bin/firewall-cmd  --permanent --zone public --add-service http"
  ignore_failure true
end

execute "reload_firewall" do
  command "/usr/bin/firewall-cmd --reload"
  ignore_failure true
end

# ---------------------------------------------------------------------------------------------------------------------
# - NODEJS Configuration -
# ---------------------------------------------------------------------------------------------------------------------
execute "nodejs rpm" do
  command "curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -"
end

package 'nodejs' do
  action :install
end

# ---------------------------------------------------------------------------------------------------------------------
# - Include Deploy and Monitor recipes -
# ---------------------------------------------------------------------------------------------------------------------
include_recipe "web::deploy"
#include_recipe "web:monitor"
