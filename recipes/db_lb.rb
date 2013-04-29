#
# Cookbook Name:: ktc-haproxy
#
# Recipe:: db_lb
#

include_recipe "haproxy"

query = "roles:mysql-master AND chef_environment:#{node.chef_environment}"
result, _, _ = Chef::Search::Query.new.search(:node, query)

if result.length == 0 
  Chef::Log.error("Found 0 result for mysql-master roles!")
else 
  vs_listen_port = result[0]["mysql"]["port"].to_s
  real_servers = result.map { |nodish| "#{nodish['hostname']}:#{vs_listen_port}" }.sort
end

haproxy_virtual_server "mysql-master" do
  action :create
  real_servers real_servers
  mode "tcp"
  options ["tcpka", "dontlognull", "tcplog", "redispatch"]
  lb_algo "source"
  vs_listen_ip "0.0.0.0"
  vs_listen_port vs_listen_port
  notifies :restart, resources(:service => "haproxy"), :immediately
end

#### to delete an individual service config

#haproxy_config "some-api" do
#  action :delete
#  notifies :restart, resources(:service => "haproxy"), :immediately
#end
