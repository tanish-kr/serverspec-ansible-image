# coding : utf-8
require 'serverspec'
require 'docker'

set :backend, :docker
set :docker_url, ENV["DOCKER_HOST"]

Excon.defaults[:ssl_verify_peer] = false
