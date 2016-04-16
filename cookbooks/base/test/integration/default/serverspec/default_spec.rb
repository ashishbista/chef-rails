require 'spec_helper'

describe 'base::default' do

  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  describe package('htop') do
    it { is_expected.to be_installed }
  end

  describe user('deploy') do
    it { is_expected.to exist }
    it { is_expected.to have_home_directory('/home/deploy') }
    it { is_expected.to have_login_shell('/bin/bash') }
    it { is_expected.to have_authorized_key('ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbVVobCYCsaeeMmCPho9WpXz4ySTftjOcmg1dDq9ID8B/xdg1q39N76V2qPtDtMG23+k7ACQMlxlVF5oxVUPI8tRgrmstxojabd2dL4MfKJRN6V9Yz2KtaWo0I4xQdoR7AFZ8+Q89JxCgjS3BrhYzfPQAhdyhZJetqJXt+a9CYzBNA0wGaQZb+c4XUSimNrYChseu7XE6MlzTeEIZoiIaS+vZecUbr0tOmONPdi7i/FEep1pEn/jw9DoXKUAXmY1zP2s5OgD+NOqEc+y5vzNQTW8FV67Ldtv3cJrnNGlc3O9EhtloKXybwFRSIZcPF/g35CrE9hsRnPRLfTh5+PzY5 ashish@poisonta') }
    it { is_expected.to belong_to_group 'sudo' }
    its(:encrypted_password) { is_exptected.to match(/^.{0,2}$/) }
  end

  describe group('sudo') do
    it { is_expected.to exist }
  end

end
