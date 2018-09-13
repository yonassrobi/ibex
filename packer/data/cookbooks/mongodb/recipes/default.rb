package "git"
package "epel-release"
package "mongodb"

%w(public logs).each do |dir|
  directory "/var/data/#{dir}" do
    owner "ec2-user"
    mode "0755"
    recursive true
  end
end

template "/etc/mongodb.conf" do
  source "mongodb.conf.erb"
  mode "0644"
end
