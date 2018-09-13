#
# Cookbook:: web
# Recipe:: deploy

# install git
package "git"

execute "Update nss curl libcurl" do
  command "yum update -y nss curl libcurl"
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

# Clone repository
git "#{node['app']['dir']}/apps" do
  destination "#{node['app']['dir']}/apps"
  repository "#{node['app']['repo']}"
  depth 1
  user node['user']['name']
  group "root"
  reference "master"
  action [:sync]
end

# Install angular cli
execute "Install angular cli" do
  cwd "#{node['app']['dir']}/apps/portal-app/"
  command "npm install -g @angular/cli"
end

# Run npm install
execute "npm install" do
  cwd "#{node['app']['dir']}/apps/portal-app/"
  command "npm install"
end

# Run ng build
execute "ng build" do
  cwd "#{node['app']['dir']}/apps/portal-app/"
  command "ng build"
end

# Change dist folder files permission
execute "build folder permission update" do
  cwd "#{node['app']['dir']}/apps/portal-app/dist"
  command "chmod -R 644 ./*"
end

# Prepare dist folder for nginx
execute "prep dist folder" do
  command "chcon -Rt httpd_sys_content_t #{node['app']['dir']}/apps/portal-app/dist/"
end
