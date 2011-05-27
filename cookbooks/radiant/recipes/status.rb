#
# Author:: Seth Chisamore <schisamo@opscode.com>
# Cookbook Name:: radiant
# Recipe:: status
#
# Copyright 2011, Opscode, Inc.
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

users = []

begin
  search(:users, 'groups:sysadmin').each do |u|
    h = {}
    h['username'] = u['id']
    if u['ssh_keys']
      gem_package "net-ssh" do
        action :nothing
      end.run_action(:install)
      require 'net/ssh'
      h['key_fingerprint'] = Net::SSH::KeyFactory.load_data_public_key(u['ssh_keys']).fingerprint
    end
    users << h
  end
rescue Net::HTTPServerException # in case the data bag doesn't exist
end

title = "Rails Quick Start"
app = data_bag_item("apps", "radiant")
organization = Chef::Config[:chef_server_url].split('/').last
pretty_run_list = node.run_list.run_list_items.collect do |item|
  "#{item.name} (#{item.role? ? "role" : "recipe" })"
end.join(", ")

template "#{::File.join(app['deploy_to'], "current")}/public/status.html" do
  source "status.html.erb"
  owner app["owner"]
  group app["group"]
  mode "0755"
  variables(
    :app => app,
    :title => title,
    :organization => organization,
    :run_list => pretty_run_list,
    :users => users
  )
end