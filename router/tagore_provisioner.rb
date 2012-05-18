require 'rubygems'
require "redis"
require 'erb'
require 'typhoeus'
require 'json'
require 'ruby-debug'

trap(:INT) { puts; exit }

NGINX_PATH = "/usr/local/bin/nginx"
SERVICES_URL = "http://localhost:3001/services.json"

class NginxProvision
  def initialize
    @redis = Redis.new
    @services = []

    provision
  end

  def update_services
    response = Typhoeus::Request.get(SERVICES_URL)
    @services = JSON.parse(response.body)
  end
  private :update_services

  def generate_config
    file = File.open('nginx.conf.erb').read
    template = ERB.new(file)
    services = @services
    @config = template.result(binding)
  end
  private :generate_config

  def update_config_file

  end
  private :update_config_file

  def provision
    update_services
    generate_config
    File.open('nginx.conf', 'w+') do |f|
      f << @config
    end
    # Update the symlink to the new nginx file
    unless `nginx -s reload`.empty?
      puts "uh oh"
    end
  end

  def looper
    @redis.subscribe(:nginx_provision) do |on|
      on.subscribe do |channel, subscriptions|
        puts "Subscribed to ##{channel} (#{subscriptions} subscriptions)"
      end

      on.message do |channel, message|
        puts "##{channel}: #{message}"
        provision

        redis.unsubscribe if message == "exit"
      end

      on.unsubscribe do |channel, subscriptions|
        puts "Unsubscribed from ##{channel} (#{subscriptions} subscriptions)"
      end
    end
  end
end

nginxprovision = NginxProvision.new
nginxprovision.looper
