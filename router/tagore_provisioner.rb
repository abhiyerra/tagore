require 'rubygems'
require "redis"
require 'erb'
require 'typhoeus'
require 'json'


trap(:INT) { puts; exit }

NGINX_PATH = "/usr/local/bin/nginx"

class NginxProvision
  def initialize
    @redis = Redis.new
    @services = []

    provision
  end

  def update_services
    response = Typhoeus::Request.get("http://www.pauldix.net")
  end
  private :update_services

  def generate_config
    ERB.new
  end
  private :generate_config

  def update_config_file

  end
  private :update_config_file

  def provision
    update_services
    generate_config
    # Update config file
    # Update the symlink to the new nginx file
    # Take nginx -s reload
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
