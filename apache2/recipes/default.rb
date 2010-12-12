#
# Cookbook Name:: apache2
# Recipe:: default
#
# Copyright 2010, TKNetworks
#

package node.apache2.package do
  action :install
end

case node.platform
when "gentoo"
  portage_use "www-servers/apache" do
    enable %w(suexec)
    notifies :reinstall, resources(:package => node.apache2.package)
  end
end

service node.apache2.service do
  action :enable
end

#include_recipe "cronolog"

# setting /etc/apache2 or /etc/httpd....
include_recipe "apache2::#{node.hostname}"
