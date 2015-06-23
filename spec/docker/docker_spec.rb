# coding : utf-8
require 'spec_helper'

describe "Dockerfile" do

  before(:all) do
    image = Docker::Image.build_from_dir('.')
    set :os, family: :redhat
    set :backend, :docker
    set :docker_image, image.id
  end

  def os_version
    command('cat /etc/issue').stdout
  end

  it 'installs the right version of CentOS' do
    expect(os_version).to match(/CentOS/)
  end

  it 'package exists' do
    expect(file('/usr/local/share/ruby-2.2.2')).to be_directory
  end

  it 'install check ruby' do
    expect(command('ls -la /usr/local/bin').stdout).to match(/ruby/)
    expect(file('/usr/local/bin/ruby')).to be_executable
    expect(command('ruby --version').stdout).to_not be nil
  end

  it 'install check serverspec' do
    expect(command('ls -la /usr/local/bin').stdout).to match(/serverspec/)
    expect(file('/usr/local/bin/gem')).to be_executable
    expect(file('/usr/local/bin/rake')).to be_executable
    expect(file('/usr/local/bin/serverspec-init')).to be_executable
    expect(command('gem list').stdout).to match(/serverspec/)
    expect(command('gem list').stdout).to match(/rake/)
  end

  it 'install check ansible' do
    expect(file('/usr/bin/ansible')).to be_executable
    expect(command('ls -la /usr/bin').stdout).to match(/ansible/)
    expect(command('ansible --version').stdout).to_not be nil
  end

end
