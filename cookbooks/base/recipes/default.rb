#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#

# Packages

# I love you, htop!

package 'htop' do
  package_name 'htop'
  action :install
end

users = data_bag('users')
users.each do |name|
  user = data_bag_item('users', name)
  home_dir = "/home/#{name}"

  user name do
    password user["password"]
    shell user["shell"]
    action [:create]
  end

  directory home_dir do
    owner name
    mode 0700
  end

  directory "#{home_dir}/.ssh" do
    owner name
    mode 0700
  end

  template "#{home_dir}/.ssh/authorized_keys" do
    owner name
    variables keys: user["ssh_keys"]
    mode 0600
  end

  bash "update-bashrc" do
    code <<-EOH
      echo ". /etc/profile" >> #{home_dir}/.bashrc
    EOH
    action :run
  end
end

group "sudo" do
  action :modify
  members "deploy"
  append true
end

