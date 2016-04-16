#
# Cookbook Name:: base
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require_relative '../../spec_helper'

describe 'base::default' do

  context 'When all attributes are default, on an unspecified platform' do
    before do
    end


    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node, server|
        server.create_data_bag('users', {
          'deploy' => {
            'password' => 'abc123',
            'ssh_keys' => [
              {'ashish-laptop' => 'ssh'}
            ],
            'shell' => '/bin/bash'
          }
        })
      end
      runner.converge(described_recipe)
    end
    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs htop' do
      expect(chef_run).to install_package('htop')
    end

    it 'creates deploy user' do
      expect(chef_run).to create_user('deploy').with(password: 'abc123', shell: '/bin/bash' )
    end

    it 'creates home direcotry for deploy user' do
       expect(chef_run).to create_directory('/home/deploy')
    end

    it 'creates .ssh directory for deploy user' do
      expect(chef_run).to create_directory('/home/deploy/.ssh')
    end

    it 'creates authorized_keys template' do
      expect(chef_run).to create_template('/home/deploy/.ssh/authorized_keys').with(
        owner:   'deploy'
      )
    end

    it 'makes deploy user sudoer' do
      expect(chef_run).to modify_group('sudo').with(members: ['deploy'], append: true)
    end

  end
end
