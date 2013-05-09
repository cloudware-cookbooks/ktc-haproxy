#
# Cookbook Name:: ktc-haproxy
#
# Recipe:: default
#

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "haproxy"
rewind :template => "/etc/haproxy/haproxy.cfg" do
  cookbook_name "ktc-haproxy"
end
